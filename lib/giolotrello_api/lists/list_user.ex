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
    |> cast(attrs, [:list_id, :user_id])
    |> validate_required([:list_id, :user_id])
    |> foreign_key_constraint(:list_id)
    |> foreign_key_constraint(:user_id)
  end
end
