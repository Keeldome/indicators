defmodule IndicatorsWeb.Router do
  use IndicatorsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {IndicatorsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", IndicatorsWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/units", UnitLive.Index, :index
    live "/units/new", UnitLive.Index, :new
    live "/units/:id/edit", UnitLive.Index, :edit

    live "/units/:id", UnitLive.Show, :show
    live "/units/:id/show/edit", UnitLive.Show, :edit

    live "/measurements", MeasurementLive.Index, :index
    live "/measurements/new", MeasurementLive.Index, :new
    live "/measurements/:id/edit", MeasurementLive.Index, :edit

    live "/measurements/:id", MeasurementLive.Show, :show
    live "/measurements/:id/show/edit", MeasurementLive.Show, :edit
  end

  scope "/api", IndicatorsWeb do
    pipe_through :api

    resources "/measurements", MeasurementController, except: [:edit]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:indicators, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: IndicatorsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
