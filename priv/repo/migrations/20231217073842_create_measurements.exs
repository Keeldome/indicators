defmodule Indicators.Repo.Migrations.CreateMeasurements do
  use Ecto.Migration

  def change do
    create table(:measurements) do
      add :temperature, :float
      add :humidity, :float
      add :unit_id, references(:units, on_delete: :nothing)

      timestamps()
    end

    create index(:measurements, [:unit_id])
  end
end
