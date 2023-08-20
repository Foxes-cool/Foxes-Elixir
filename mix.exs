defmodule Foxes.MixProject do
  use Mix.Project

  def project do
    [
      app: :foxes,
      name: "Foxes",
      version: "1.0.0",
      description: "An API for all your fox image needs",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "Homepage": "https://foxes.cool", 
        "Github": "https://github.com/Foxes-cool/Foxes-Elixir"
      },
    ]
  end
  
  defp docs do
    [
      main: "readme",
      logo: "logo.png"
    ]
  end
end
