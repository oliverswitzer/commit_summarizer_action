defmodule CommitSummarizerAction.MixProject do
  use Mix.Project

  def project do
    [
      app: :commit_summarizer_action,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {CommitSummarizerAction.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:oauth2, "~> 2.0"}
    ]
  end
end
