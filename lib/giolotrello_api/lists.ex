defmodule GiolotrelloApi.Lists do
  @moduledoc """
  The Lists context.
  """

  import Ecto.Query, warn: false

  alias GiolotrelloApi.Repo
  alias GiolotrelloApi.Lists.{List, ListUser}

  def get_list!(id) do
    Repo.get!(List, id)
  end

  def create_list_with_owner(attrs, user_id) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:list, List.changeset(%List{}, attrs))
    |> Ecto.Multi.run(:list_user, fn repo, %{list: list} ->
      list_user_attrs = %{"list_id" => list.id, "user_id" => user_id}
      %ListUser{}
      |> ListUser.changeset(list_user_attrs)
      |> repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{list: list}} -> {:ok, list}
      {:error, step, reason, _changes} -> {:error, step, reason}
    end
  end

  def update_list(%List{} = list, attrs) do
    list
    |> List.changeset(attrs)
    |> Repo.update()
  end

  def delete_list(%List{} = list) do
    Repo.delete(list)
  end

  def list_users_for_list(list_id) do
    from(lu in ListUser, where: lu.list_id == ^list_id, preload: [:user])
    |> Repo.all()
  end

  def add_user_to_list(list_id, user_id) do
    %ListUser{}
    |> ListUser.changeset(%{list_id: list_id, user_id: user_id})
    |> Repo.insert()
  end

  def remove_user_from_list(list_id, user_id) do
    from(lu in ListUser, where: lu.list_id == ^list_id and lu.user_id == ^user_id)
    |> Repo.one()
    |> case do
      nil -> {:error, :not_found}
      lu  -> Repo.delete(lu)
    end
  end

  def user_can_update_list?(list_id, user_id) do
    query =
      from lu in ListUser,
        where: lu.list_id == ^list_id and lu.user_id == ^user_id

    Repo.exists?(query)
  end
end
