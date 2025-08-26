defmodule GiolotrelloApi.Repo.Migrations.AddPositionToTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :position, :float
    end
  end
end
