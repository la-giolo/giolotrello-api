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
      comments: Enum.map(task.comments || [], &comment_data/1)
    }
  end

  defp comment_data(%Comment{} = comment) do
    %{
      id: comment.id,
      body: comment.body,
      user_id: comment.user_id,
      inserted_at: comment.inserted_at,
      updated_at: comment.updated_at
    }
  end
end
