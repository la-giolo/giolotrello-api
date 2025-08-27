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

  def get_task!(id), do: Repo.get!(Task, id)

  def create_task(attrs \\ %{}) do
    max_position =
      Task
      |> where(list_id: ^attrs["list_id"])
      |> select([t], max(t.position))
      |> Repo.one() || 0

    attrs = Map.put(attrs, "position", max_position + 1000)

    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def update_task(%Task{} = task, %{"after_task_id" => after_task_id} = attrs) do
    case after_task_id do
      # Move to top
      nil ->
        first_task =
          Task
          |> where([t], t.list_id == ^task.list_id and t.id != ^task.id)
          |> order_by(:position)
          |> limit(1)
          |> Repo.one()

        new_position =
          case first_task do
            nil -> 1000
            t -> t.position / 2
          end

        attrs = Map.put(attrs, "position", new_position)

        task
        |> Task.changeset(attrs)
        |> Repo.update()

      # Move after another task
      after_task_id ->
        after_task = Repo.get!(Task, after_task_id)

        next_task =
          Task
          |> where([t], t.list_id == ^after_task.list_id and t.position > ^after_task.position)
          |> order_by(:position)
          |> limit(1)
          |> Repo.one()

        new_position =
          case next_task do
            nil -> after_task.position + 1000
            t -> (after_task.position + t.position) / 2
          end

        attrs = Map.put(attrs, "position", new_position)
        task |> Task.changeset(attrs) |> Repo.update()
    end
  end

  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @spec change_task(%GiolotrelloApi.Tasks.Task{optional(atom()) => any()}) :: Ecto.Changeset.t()
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
