defmodule GiolotrelloApiWeb.TaskJSON do
  alias GiolotrelloApi.Tasks.Task
  alias GiolotrelloApi.Comments.Comment

  def index(%{tasks: tasks}) do
    %{data: Enum.map(tasks, &show/1)}
  end

  def show(%{task: %Task{} = task}) do
    data(task)
  end

  def show(%Task{} = task), do: data(task)

  defp data(%Task{} = task) do
    %{
      id: task.id,
      title: task.title,
      description: task.description,
      list_id: task.list_id,
      assignee_id: task.assignee_id,
      position: task.position,
      inserted_at: task.inserted_at,
      updated_at: task.updated_at,
      comments: task_comments(task.comments)
    }
  end

  defp comment_data(%Comment{} = comment) do
    %{
      id: comment.id,
      body: comment.body,
      user_id: comment.user_id,
      email: comment.user.email,
      inserted_at: comment.inserted_at,
      updated_at: comment.updated_at
    }
  end

  defp task_comments(%Ecto.Association.NotLoaded{}), do: []
  defp task_comments(comments), do: Enum.map(comments, &comment_data/1)
end
