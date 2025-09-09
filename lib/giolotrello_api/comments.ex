defmodule GiolotrelloApi.Comments do
  @moduledoc """
  The Comments context.
  """

  import Ecto.Query, warn: false
  alias GiolotrelloApi.Repo
  alias GiolotrelloApi.Comments.Comment

  def list_comments do
    Comment
    |> Repo.all()
    |> Repo.preload(:user)
  end

  def list_comments_by_task(task_id) do
    Comment
    |> where(task_id: ^task_id)
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @spec get_comment!(any()) :: any()
  def get_comment!(id), do: Repo.get!(Comment, id)

  def list_comments(task_id) do
    Comment
    |> where(task_id: ^task_id)
    |> preload(:user)
    |> Repo.all()
  end

  def create_comment(attrs) do
    %Comment{}
    |> Comment.create_changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, comment} ->
        {:ok, Repo.preload(comment, :user)}
      error ->
        error
    end
  end


  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end
end
