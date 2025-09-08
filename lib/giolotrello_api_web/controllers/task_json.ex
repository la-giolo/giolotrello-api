defmodule GiolotrelloApiWeb.TaskJSON do
  alias GiolotrelloApi.Tasks.Task

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
      updated_at: task.updated_at
    }
  end
end
