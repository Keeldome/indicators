defmodule Indicators.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      IndicatorsWeb.Telemetry,
      # Start the Ecto repository
      Indicators.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Indicators.PubSub},
      # Start Finch
      {Finch, name: Indicators.Finch},
      # Start the Endpoint (http/https)
      IndicatorsWeb.Endpoint
      # Start a worker by calling: Indicators.Worker.start_link(arg)
      # {Indicators.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Indicators.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IndicatorsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
