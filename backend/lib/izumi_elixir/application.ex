defmodule Izumi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Izumi.Worker.start_link(arg)
      # {Izumi.Worker, arg}
      {Bandit, plug: Izumi.Endpoint},
      {Mongo,
        name: :mongo,
        url: Application.fetch_env!(:izumi, :mongodb_url),
        database: Application.fetch_env!(:izumi, :mongodb_database),
        ssl: true,
        ssl_opts: [
          verify: :verify_peer,
          cacerts: :public_key.cacerts_get(),
          customize_hostname_check: [
            match_fun:
              :public_key.pkix_verify_hostname_match_fun(:https)
          ]
        ]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Izumi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
