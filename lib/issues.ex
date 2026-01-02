defmodule Issues do
  @moduledoc """
  Documentation for `Issues`.
  """

  defdelegate main(argv), to: Issues.CLI
end
