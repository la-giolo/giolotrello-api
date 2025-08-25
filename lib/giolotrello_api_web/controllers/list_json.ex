defmodule GiolotrelloApiWeb.ListJSON do
  alias GiolotrelloApi.Lists.List

  def show(%{list: %List{} = list}) do
    %{data: data(list)}
  end

  def index(%{lists: lists}) do
    %{data: Enum.map(lists, &data/1)}
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
