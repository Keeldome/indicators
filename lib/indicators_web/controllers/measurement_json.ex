defmodule IndicatorsWeb.MeasurementJSON do
  alias Indicators.Measurments.Measurement

  @doc """
  Renders a list of measurements.
  """
  def index(%{measurements: measurements}) do
    %{data: for(measurement <- measurements, do: data(measurement))}
  end

  @doc """
  Renders a single measurement.
  """
  def show(%{measurement: measurement}) do
    %{data: data(measurement)}
  end

  defp data(%Measurement{} = measurement) do
    %{
      id: measurement.id
    }
  end
end
