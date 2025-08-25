defmodule GiolotrelloApi.Lists do
  @moduledoc """
  The Lists context.
  """

  import Ecto.Query, warn: false

  alias GiolotrelloApi.Repo
  alias GiolotrelloApi.Lists.ListUser

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
end
