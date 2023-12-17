defmodule Indicators.Measurments.Measurement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "measurements" do
    field :temperature, :float
    field :humidity, :float
    field :unit_id, :id

    timestamps()
  end

  @doc false
  def changeset(measurement, attrs) do
    measurement
    |> cast(attrs, [:temperature, :humidity, :unit_id])
    |> validate_required([:temperature, :humidity])
  end
end
