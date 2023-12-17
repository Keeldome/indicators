defmodule IndicatorsWeb.MeasurementLive.Index do
  use IndicatorsWeb, :live_view

  alias Indicators.Measurments
  alias Indicators.Measurments.Measurement

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :measurements, Measurments.list_measurements())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Measurement")
    |> assign(:measurement, Measurments.get_measurement!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Measurement")
    |> assign(:measurement, %Measurement{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Measurements")
    |> assign(:measurement, nil)
  end

  @impl true
  def handle_info({IndicatorsWeb.MeasurementLive.FormComponent, {:saved, measurement}}, socket) do
    {:noreply, stream_insert(socket, :measurements, measurement)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    measurement = Measurments.get_measurement!(id)
    {:ok, _} = Measurments.delete_measurement(measurement)

    {:noreply, stream_delete(socket, :measurements, measurement)}
  end
end
