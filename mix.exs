defmodule Private.Mixfile do
  use Mix.Project

  @deps     []
  @version "0.1.0"
  @name    :private

  ############################################################
  
  def project do
    in_production = Mix.env == :prod
    [
      app:     @name,
      version: @version,
      elixir:  ">= 1.4.0",
      deps:     @deps,
      package:  package(),
      description:     "Make private functions public if Mix.env is :test",
      build_embedded:  in_production,
      start_permanent: in_production,
    ]
  end

  def application do
    [
    ]
  end

  defp package do
    [
      name:        @name,
      files:       ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Eric Meadows-Jönsson", "José Valim"],
      licenses:    ["Apache 2.0"],
      links:       %{"GitHub" => "https://github.com/pragdave/private"},
    ]
  end  
end
