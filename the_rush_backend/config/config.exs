# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :the_rush_backend,
  ecto_repos: [TheRushBackend.Repo]

# Configures the endpoint
config :the_rush_backend, TheRushBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6hrZvS/0Z/4/nvqE01Cxv6tBMIBXI8RXy2ncG1naa23RPAiwDv4DTocYmMR6pdZ4",
  render_errors: [view: TheRushBackendWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TheRushBackend.PubSub,
  live_view: [signing_salt: "byktj9Tw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
