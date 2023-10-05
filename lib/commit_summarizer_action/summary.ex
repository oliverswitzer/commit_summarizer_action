defmodule CommitSummarizerAction.Summary do
  @openai_url "https://api.openai.com/v1/engines/text-davinci-003/completions"
  @max_chunk_size 2048
  @prompt_template """
  Write a git commit message for the following git diff. The message
  starts with a one-line summary of 60 characters, followed by a
  blank line, followed by a longer but concise description of the
  change.

  %s
  """

  def generate(diff) do
    chunks = chunk_diff(diff, @max_chunk_size)
    summaries = Enum.map(chunks, &get_summary_for_chunk(&1))
    Enum.join(summaries, "\n\n")
  end

  defp chunk_diff(diff, size) do
    String.split_at(diff, size)
  end

  defp get_summary_for_chunk(chunk) do
    prompt = :io.format(@prompt_template, [chunk])

    headers = [
      {"Authorization",
       "Bearer #{Application.get_env(:commit_summarizer_action, :openai_api_token)}"},
      {"Content-Type", "application/json"}
    ]

    body = %{
      "prompt" => prompt,
      "max_tokens" => 150
    }

    case Req.post(@openai_url, headers: headers, body: Jason.encode!(body)) do
      {:ok, response} when response.status_code == 200 ->
        Jason.decode!(response.body)["choices"]
        |> List.first()
        |> Map.get("text")
        |> String.trim()

      {:error, error} ->
        IO.puts("Error contacting OpenAI: #{inspect(error)}")
        "Error generating summary. Please try again later."

      {:ok, response} ->
        IO.puts("Error with OpenAI response: #{response.body}")
        "Error generating summary. Please try again later."
    end
  end
end

