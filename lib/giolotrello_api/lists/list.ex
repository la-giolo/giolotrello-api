defmodule GiolotrelloApi.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :title, :string

    has_many :tasks, GiolotrelloApi.Tasks.Task, on_delete: :delete_all
    has_many :list_users, GiolotrelloApi.Lists.ListUser, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
