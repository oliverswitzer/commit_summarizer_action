defmodule CommitSummarizerAction.Watcher do
  use GenServer
  alias CommitSummarizerAction.{PR, Comment, Diff, Summary}

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    diff = Keyword.get(opts, :diff)
    repo = Keyword.get(opts, :repo)
    {:ok, %{diff: diff, repo: repo}}
  end

  def handle_info({:commit, commit}, %{diff: diff, repo: repo}) do
    if commit_contains_keyword?(commit) do
      branch = get_branch(commit)

      unless branch == "main" do
        pr = PR.create(branch, repo)
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
