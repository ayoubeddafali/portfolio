defmodule Portfolio.Mixfile do
  use Mix.Project

  def project do
    [app: :portfolio,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Portfolio, []},
     applications: [
       :phoenix,
       :phoenix_pubsub,
       :phoenix_html,
       :cowboy,
       :logger,
       :gettext,
       :porcelain,
       :mogrify,
       :bootform,
       :ecto,
       :phoenix_ecto,
       :poison
      ]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
     {:phoenix, "~> 1.2.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:mix_test_watch, "~> 0.3", only: :dev, runtime: false},
     {:fs, "~> 2.12", override: true},
     {:porcelain, "~> 2.0"},
     {:mogrify, "~> 0.5.4"},
     {:bootform, "~> 0.1.2"},
     {:ecto, "~> 2.1"},
     {:poison, "~> 2.0"}
   ]
  end
end
