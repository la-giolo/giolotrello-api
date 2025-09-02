defmodule GiolotrelloApi.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :title, :string
    field :description, :string
    field :assignee_id, :id
    field :position, :float

    belongs_to :list, GiolotrelloApi.Lists.List
    has_many :comments, GiolotrelloApi.Comments.Comment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :list_id, :assignee_id, :position])
    |> validate_required([:title, :list_id])
  end
end
