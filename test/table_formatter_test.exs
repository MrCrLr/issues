defmodule TableFormatterTest do
  use ExUnit.Case    # bring in the test functionality
  import ExUnit.CaptureIO

  alias Issues.TableFormatter, as: TF

  @simple_test_data [
    [ c1: "r1 c1", c2: "r1 c2",  c3: "r1 c3", c4: "r1+++c4" ],
    [ c1: "r2 c1", c2: "r2 c2",  c3: "r2 c3", c4: "r2 c4"   ],
    [ c1: "r3 c1", c2: "r3 c2",  c3: "r3 c3", c4: "r3 c4"   ],
    [ c1: "r4 c1", c2: "r4++c2", c3: "r4 c3", c4: "r4 c4"   ]
  ]
  @headers [ :c1, :c2, :c4 ]

  def split_with_three_columns do
    TF.split_into_columns(@simple_test_data, @headers)
  end

  test "split_into_columns returns columns aligned with headers" do
    columns = split_with_three_columns()

    assert length(columns) == length(@headers)

    Enum.each(columns, fn column ->
      assert length(column) == length(@simple_test_data)
      assert Enum.all?(column, &is_binary/1)
    end)
  end

  test "column_widths reflect formatted column widths" do
    widths = TF.widths_of(split_with_three_columns())

    assert length(widths) == length(@headers)
    assert Enum.all?(widths, &is_integer/1)
    assert Enum.all?(widths, &(&1 > 0))
  end

  test "Output contains formatted table with headers and rows" do
    result =
      capture_io(fn ->
        TF.print_table_for_columns(@simple_test_data, @headers)
      end)

    # Headers
    assert result =~ "c1"
    assert result =~ "c2"
    assert result =~ "c4"

    # Row content (possibly truncated)
    [_data_header, _separator | rows] =
      result
      |> String.split("\n", trim: true)

    assert length(rows) == length(@simple_test_data)

    # Table structure
    assert result =~ "|"
    assert result =~ "+"
    assert String.contains?(result, "\n")
  end

  test "long values are truncated with ellipsis" do
    result =
      capture_io(fn ->
        TF.print_table_for_columns(@simple_test_data, @headers)
      end)

    assert result =~ "..."
  end

end

