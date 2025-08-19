defmodule GiolotrelloApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :string
      add :list_id, references(:lists, on_delete: :nothing)
      add :assignee_id, references(:users, on_delete: :nilify_all), null: true

      timestamps(type: :utc_datetime)
    end

    create index(:tasks, [:list_id])
    create index(:tasks, [:assignee_id])
  end
end
