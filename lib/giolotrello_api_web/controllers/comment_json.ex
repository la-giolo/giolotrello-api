defmodule GiolotrelloApiWeb.CommentJSON do
  alias GiolotrelloApi.Comments.Comment

  def index(%{comments: comments}) do
    %{data: for(comment <- comments, do: data(comment))}
  end

  def show(%{comment: comment}) do
    %{data: data(comment)}
  end

  defp data(%Comment{} = comment) do
    %{
      id: comment.id,
      body: comment.body,
      user_id: comment.user_id,
      email: comment.user.email,
      task_id: comment.task_id
    }
  end
end
