defmodule CommitSummarizerAction.Application do
  use Application

  def start(_type, args) do
    parsed = OptionParser.parse(args, switches: [diff: :string, repo: :string])

    # Start the GenServer with the diff as an initial state
    CommitSummarizerAction.Watcher.start_link(parsed)
  end
end
