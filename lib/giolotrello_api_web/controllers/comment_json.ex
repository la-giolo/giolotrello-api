defmodule GiolotrelloApiWeb.CommentJSON do
  alias GiolotrelloApi.Comments.Comment
  alias GiolotrelloApi.Users.User

  def index(%{comments: comments}) do
    %{data: for(comment <- comments, do: data(comment))}
  end

  def show(%{comment: comment}) do
    %{data: data(comment)}
  end

  defp data(%Comment{} = comment) do
    %{
      "id" => comment.id,
      "body" => comment.body,
      "user_id" => comment.user_id,
      "task_id" => comment.task_id,
      "email" => get_user_email(comment.user)
    }
  end

  defp get_user_email(%User{email: email}), do: email
  defp get_user_email(_), do: nil
end
