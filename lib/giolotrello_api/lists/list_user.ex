defmodule GiolotrelloApi.Lists.ListUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list_users" do
    belongs_to :list, GiolotrelloApi.Lists.List
    belongs_to :user, GiolotrelloApi.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(list_user, attrs) do
    list_user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
