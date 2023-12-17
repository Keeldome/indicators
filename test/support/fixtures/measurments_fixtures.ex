defmodule Indicators.MeasurmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Indicators.Measurments` context.
  """

  @doc """
  Generate a measurement.
  """
  def measurement_fixture(attrs \\ %{}) do
    {:ok, measurement} =
      attrs
      |> Enum.into(%{
        humidity: 120.5,
        temperature: 120.5
      })
      |> Indicators.Measurments.create_measurement()

    measurement
  end
end
