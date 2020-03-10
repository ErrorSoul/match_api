defmodule MatchApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    redis = System.get_env("REDIS_URL")
    port = System.get_env("PORT") |> String.to_integer

    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: MatchApi.Endpoint,
        options: [port: port]
      ),
      {Redix, {redis, [name: :redix]}}
    ]

    opts = [strategy: :one_for_one, name: MatchApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
