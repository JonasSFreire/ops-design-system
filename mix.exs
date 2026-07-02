defmodule OpsDesignSystem.MixProject do
  use Mix.Project

  def project do
    [
      app: :ops_design_system,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description:
        "Tokens-first design system for internal apps: one CSS import for any stack, HEEx components for Phoenix/LiveView.",
      package: package()
    ]
  end

  def application do
    [extra_applications: []]
  end

  defp deps do
    [
      {:phoenix_live_view, "~> 1.0"},
      {:lazy_html, ">= 0.1.0", only: :test}
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md index.css tokens.css components.css),
      licenses: ["Apache-2.0"],
      links: %{}
    ]
  end
end
