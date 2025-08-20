defmodule GiolotrelloApi.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias GiolotrelloApi.Repo

  alias GiolotrelloApi.Tasks.Task

  # List all tasks
  def list_tasks do
    Repo.all(Task)
  end

  # Get a single task (raises if not found)
  def get_task!(id), do: Repo.get!(Task, id)

  # Create a task
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  # Update a task
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  # Delete a task
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  # Return a changeset for tracking changes
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
