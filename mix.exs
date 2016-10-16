defmodule Pke.Mixfile do
  use Mix.Project

  def project do
    [app: :pke,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :crypto],
     mod: {Pke, []}]
  end

  defp deps do
    []
  end
end
