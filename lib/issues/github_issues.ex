defmodule Issues.GithubIssues do
  @user_agent [{"user-agent", "MrCrLr"}]
  @github_url Application.compile_env!(:issues, :github_url)

  def fetch(user, repo) do
    Req.new(
      base_url: @github_url,
      headers: @user_agent
    )
    |> Req.get!(url: "/repos/#{user}/#{repo}/issues")
    |> then(&handle_response/1)
  end

  def handle_response(%{status: 200, body: body}) do
    {:ok, body}
  end
  
  def handle_response(%{status: s, body: body}) do
    {:error, %{status: s, body: body}}
  end
end
