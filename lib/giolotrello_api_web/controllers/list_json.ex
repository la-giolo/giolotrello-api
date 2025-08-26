defmodule GiolotrelloApiWeb.ListJSON do
  alias GiolotrelloApi.Lists.List
  alias GiolotrelloApiWeb.TaskJSON

  def show(%{list: %List{} = list}) do
    %{data: data(list)}
  end

  def index(%{lists: lists}) do
    %{
      lists: Enum.map(lists, &list_with_tasks/1)
    }
  end

  defp list_with_tasks(list) do
    %{
      id: list.id,
      title: list.title,
      tasks: Enum.map(list.tasks, &TaskJSON.show/1)
    }
  end

  defp data(%List{id: id, title: title, inserted_at: inserted_at, updated_at: updated_at}) do
    %{
      id: id,
      title: title,
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end
end
