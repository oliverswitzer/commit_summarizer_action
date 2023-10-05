defmodule CommitSummarizerAction.PR do
  def create(branch_name, repo) do
    owner = "TBD, prob this bot"

    params = %{
      "title" => "Automatic PR by Commit Summarizer",
      "head" => branch_name,
      "base" => "main",
      "body" => "Automatic PR created by CommitSummarizerAction"
    }

    {:ok, response} = Tentacat.PullRequests.create(owner, repo, params)

    {:ok, response}
  end
end

