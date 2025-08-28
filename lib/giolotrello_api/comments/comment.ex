defmodule GiolotrelloApi.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    belongs_to :task, GiolotrelloApi.Tasks.Task
    belongs_to :user, GiolotrelloApi.Users.User

    timestamps(type: :utc_datetime)
  end

  def create_changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :task_id, :user_id])
    |> validate_required([:body, :task_id, :user_id])
    |> foreign_key_constraint(:task_id)
    |> foreign_key_constraint(:user_id)
  end

  def update_changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
