defmodule CommitSummarizerAction.Watcher do
  use GenServer
  alias CommitSummarizerAction.{PR, Comment, Diff, Summary}

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    {:ok, %{}}
  end

  def handle_info({:commit, commit}, state) do
    if commit_contains_keyword?(commit) do
      branch = get_branch(commit)
      unless branch == "main" do
        pr = PR.create(branch)
        diff = Diff.get(commit)
        summary = Summary.generate(diff)
        Comment.post(pr, summary)
      end
    end

    {:noreply, state}
  end

  defp commit_contains_keyword?(commit) do
    String.contains?(commit.message, "[summarize]")
  end

  defp get_branch(commit) do
    commit.branch
  end
end
