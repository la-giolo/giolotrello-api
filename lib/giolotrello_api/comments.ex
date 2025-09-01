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

  def get_comment!(id), do: Repo.get!(Comment, id)

  def create_comment(attrs) do
    %Comment{}
    |> Comment.create_changeset(attrs)
    |> Repo.insert()
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
