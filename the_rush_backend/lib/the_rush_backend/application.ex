defmodule TheRushBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TheRushBackend.Repo,
      # Start the Telemetry supervisor
      TheRushBackendWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TheRushBackend.PubSub},
      # Start the Endpoint (http/https)
      TheRushBackendWeb.Endpoint
      # Start a worker by calling: TheRushBackend.Worker.start_link(arg)
      # {TheRushBackend.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TheRushBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TheRushBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
