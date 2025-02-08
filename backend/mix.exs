defmodule Izumi.MixProject do
  use Mix.Project

  def project do
    [
      app: :izumi,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Izumi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, "~> 1.6"},
      {:bcrypt_elixir, "~> 3.2"},
      {:ecto, "~> 3.12"},
      {:ecto_sqlite3, "~> 0.18.0"},
      {:exsync, "~> 0.4", only: :dev},
      {:jason, "~> 1.4"},
      {:joken, "~> 2.6"},
      {:mongodb_driver, "~> 1.5.0"},
      {:peri, "~> 0.3"},
      {:plug, "~> 1.16"},
      {:uuid, "~> 1.1" },
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
