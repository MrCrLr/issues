defmodule Issues.TableFormatter do

  import Enum, only: [ each: 2, map: 2, map_join: 3, max: 1 ]

  @max_widths %{
     "number" => 6,
     "created_at" => 20,
     "title" => 60
  }

  def print_table_for_columns(rows, headers) do
    with data_by_columns = split_into_columns(rows, headers),
         column_widths   = widths_of(data_by_columns),
         format          = format_for(column_widths)
    do
         puts_one_line_in_columns(headers, format)
         IO.puts(separator(column_widths))
         puts_in_columns(data_by_columns, format)
    end
  end
  @doc """
  Given a list of rows, where each row contains a keyed list
  of columns, return a list containing lists of the data in
  each column. The `headers` parameter contains the
  list of columns to extract.

  ## Example
      iex> list = [Enum.into([{"a", "1"},{"b", "2"},{"c", "3"}], %{}),
      ...> Enum.into([{"a", "4"},{"b", "5"},{"c", "6"}], %{})]
      iex> Issues.TableFormatter.split_into_columns(list, [ "a", "b", "c" ])
      [ ["1", "4"], ["2", "5"], ["3", "6"] ]
  """
  def split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows, do: printable(row[header], header)
    end
  end

  @doc """
  Return a binary (string) version of our parameter.

  ## Example
      iex> Issues.TableFormatter.printable("a", "title")
      "a"
      iex> Issues.TableFormatter.printable(99, "created_at")
      "99"
  """
  def printable(value, header) do
    string = to_string(value)
    max = max_width(header)

    if String.length(string) > max do 
      String.slice(string, 0, max - 1) <> "..."
    else 
      string 
    end
  end

  defp max_width(header) do
    h = header_to_string(header)
    Map.get(@max_widths, h, String.length(h))
  end

  defp header_to_string(header) when is_atom(header), do: Atom.to_string(header)
  defp header_to_string(header), do: header

  def widths_of(columns) do
    for column <- columns, do: column |> map(&String.length/1) |> max
  end

  def format_for(column_widths) do
    map_join(column_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def separator(column_widths) do
    map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  def puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> Enum.zip
    |> map(&Tuple.to_list/1)
    |> each(&puts_one_line_in_columns(&1, format))
  end

  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end
end
