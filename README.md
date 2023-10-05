To implement this, we will need the following core classes and functions:

1. `CommitSummarizerAction`: This is the main class that will handle the Github action. It will have methods to watch for commits, check for the "summarize" keyword, create a PR, get the diff of the commit, generate a summary using ChatGPT's API, and post the summary as a comment to the PR.

2. `watch_for_commits`: This method will watch for commits on the branches it's configured to watch.

3. `check_for_keyword`: This method will check for the "summarize" keyword in the commit.

4. `create_pr`: This method will create a PR for the branch.

5. `get_diff`: This method will get the diff contents of the commit.

6. `generate_summary`: This method will generate a high-level summary of the commit using ChatGPT's API.

7. `post_summary`: This method will post the summary as a comment to the PR.

Now, let's write the code for each of these components.

`mix.exs`
