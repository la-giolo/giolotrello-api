defmodule GiolotrelloApiWeb.TaskJSON do
  alias GiolotrelloApi.Tasks.Task

  def index(%{tasks: tasks}) do
    %{data: (for task <- tasks, do: show(task))}
  end

  def show(%Task{} = task) do
    %{
      id: task.id,
      title: task.title,
      description: task.description,
      list_id: task.list_id,
      assignee_id: task.assignee_id,
      inserted_at: task.inserted_at,
      updated_at: task.updated_at
    }
  end
end
