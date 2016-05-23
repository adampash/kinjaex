defmodule Kinja.Mixfile do
  use Mix.Project

  def project do
    [app: :kinja,
    version: "0.0.1",
    elixir: "~> 1.2",
    build_embedded: Mix.env == :prod,
    start_permanent: Mix.env == :prod,
    description: description,
    package: package,
    deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.8.0"},
      {:credo, "~> 0.3", only: [:dev, :test]},
      {:poison, "~> 2.1"},
    ]
  end

  defp description do
    """
    A wrapper for the Kinja API.
    """
  end

  defp package do
    [# These are the default files included in the package
    name: :kinja,
    files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
    maintainers: ["Adam Pash"],
    licenses: ["Apache 2.0"],
    links: %{"GitHub" => "https://github.com/adampash/kinjaex",
    "Docs" => "https://github.com/adampash/kinjaex"}]
  end

end
