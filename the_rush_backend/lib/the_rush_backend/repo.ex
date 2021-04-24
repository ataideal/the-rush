defmodule TheRushBackend.Repo do
  use Ecto.Repo,
    otp_app: :the_rush_backend,
    adapter: Ecto.Adapters.Postgres
end
