defmodule Issues.GithubIssues do

  require Logger

  @user_agent [{"user-agent", "MrCrLr"}]

  @github_url Application.compile_env!(:issues, :github_url)

  def fetch(user, repo) do
    Logger.info("Fetching #{user}'s project #{repo}")

    Req.new(
      base_url: @github_url,
      headers: @user_agent
    )
    |> Req.get!(url: "/repos/#{user}/#{repo}/issues?state=all")
    |> then(&handle_response/1)
  end

  def handle_response(%{status: status_code, body: body}) do
    Logger.info("Got response: status code=#{status_code}")
    Logger.debug(fn -> inspect(body) end)
    {
      status_code |> check_for_error(),
      body
    } 
  end
  
  def check_for_error(200), do: :ok
  def check_for_error(_),   do: :error

end
