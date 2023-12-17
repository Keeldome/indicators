defmodule IndicatorsWeb.MeasurementLive.FormComponent do
  use IndicatorsWeb, :live_component

  alias Indicators.Measurments

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage measurement records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="measurement-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:temperature]} type="number" label="Temperature" step="any" />
        <.input field={@form[:humidity]} type="number" label="Humidity" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Measurement</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{measurement: measurement} = assigns, socket) do
    changeset = Measurments.change_measurement(measurement)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"measurement" => measurement_params}, socket) do
    changeset =
      socket.assigns.measurement
      |> Measurments.change_measurement(measurement_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"measurement" => measurement_params}, socket) do
    save_measurement(socket, socket.assigns.action, measurement_params)
  end

  defp save_measurement(socket, :edit, measurement_params) do
    case Measurments.update_measurement(socket.assigns.measurement, measurement_params) do
      {:ok, measurement} ->
        notify_parent({:saved, measurement})

        {:noreply,
         socket
         |> put_flash(:info, "Measurement updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_measurement(socket, :new, measurement_params) do
    case Measurments.create_measurement(measurement_params) do
      {:ok, measurement} ->
        notify_parent({:saved, measurement})

        {:noreply,
         socket
         |> put_flash(:info, "Measurement created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
