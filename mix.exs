defmodule MatchApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :match_api,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {MatchApi.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.1"},
      {:poison, "~> 4.0.1"},
      {:redix, "~> 0.10.5"}
    ]
  end
end
