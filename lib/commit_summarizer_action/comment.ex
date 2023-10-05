defmodule CommitSummarizerAction.Comment do
  def post(pr_number, message, owner, repo) do
    params = %{"body" => message}
    {:ok, response} = Tentacat.Issues.Comments.create(owner, repo, pr_number, params)
    {:ok, response}
  end
end
