defmodule IndicatorsWeb.MeasurementController do
  use IndicatorsWeb, :controller

  alias Indicators.Measurments
  alias Indicators.Measurments.Measurement

  action_fallback IndicatorsWeb.FallbackController

  def index(conn, _params) do
    measurements = Measurments.list_measurements()
    render(conn, :index, measurements: measurements)
  end

  def create(conn, measurement_params) do
    with {:ok, %Measurement{} = measurement} <- Measurments.create_measurement(measurement_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/measurements/#{measurement}")
      |> render(:show, measurement: measurement)
    end
  end

  def show(conn, %{"id" => id}) do
    measurement = Measurments.get_measurement!(id)
    render(conn, :show, measurement: measurement)
  end

  def update(conn, %{"id" => id, "measurement" => measurement_params}) do
    measurement = Measurments.get_measurement!(id)

    with {:ok, %Measurement{} = measurement} <- Measurments.update_measurement(measurement, measurement_params) do
      render(conn, :show, measurement: measurement)
    end
  end

  def delete(conn, %{"id" => id}) do
    measurement = Measurments.get_measurement!(id)

    with {:ok, %Measurement{}} <- Measurments.delete_measurement(measurement) do
      send_resp(conn, :no_content, "")
    end
  end
end
