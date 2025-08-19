defmodule GiolotrelloApi.Repo.Migrations.CreateListUsers do
  use Ecto.Migration

  def change do
    create table(:list_users) do
      add :list_id, references(:lists, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:list_users, [:list_id, :user_id])
  end
end
