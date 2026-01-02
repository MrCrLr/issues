defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app:             :issues,
      name:            "Issues",
      source_url:      "https://github.com/mrcrlr/issues",
      escript:         escript_config(),
      version:         "0.0.1",
      elixir:          "~> 1.19",
      build_embedded:  Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      test_coverage:   [tool: ExCoveralls],
      deps:            deps()
    ]
  end

  def cli do
    [
      preferred_envs: [ 
       coveralls:          :test, 
       "coveralls.detail": :test, 
       "coveralls.post":   :test, 
       "coveralls.html":   :test,
       "coveralls.cobertura": :test
    ]]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :req,         "~> 0.5.16" },
      { :ex_doc,      "~> 0.34"   },
      { :earmark,     "~> 1.4.47" },
      { :excoveralls, "~> 0.18.5" }
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
  defp escript_config do
    [
      main_module: Issues
    ]
  end
end
