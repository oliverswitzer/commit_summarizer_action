defmodule CommitSummarizerAction.Application do
  use Application

  def start(_type, _args) do
    children = [
      CommitSummarizerAction.Watcher
    ]

    opts = [strategy: :one_for_one, name: CommitSummarizerAction.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
