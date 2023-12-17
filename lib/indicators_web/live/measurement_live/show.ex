defmodule IndicatorsWeb.MeasurementLive.Show do
  use IndicatorsWeb, :live_view

  alias Indicators.Measurments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:measurement, Measurments.get_measurement!(id))}
  end

  defp page_title(:show), do: "Show Measurement"
  defp page_title(:edit), do: "Edit Measurement"
end
