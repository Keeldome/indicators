defmodule Indicators.Repo do
  use Ecto.Repo,
    otp_app: :indicators,
    adapter: Ecto.Adapters.Postgres
end
