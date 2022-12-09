{:ok, data} = File.read("input.txt")

to_table = fn data ->
  String.split(data, "\n")
  |> Enum.map(fn line ->
    String.split(line, "")
    |> Enum.slice(1..-2)
    |> Enum.map(fn item ->
      elem(Integer.parse(item), 0)
    end)
  end)
end

get_row = fn table, row ->
  Enum.at(table, row)
end

get_column = fn table, column ->
  Enum.map(table, fn row ->
    Enum.at(row, column)
  end)
  |> List.flatten()
end

check_row_visibility = fn row, pos ->
  left = Enum.slice(row, 0..pos-1)
  |> Enum.all?(fn item ->
    item < Enum.at(row, pos)
  end)
  right = Enum.slice(row, pos+1..length(row))
  |> Enum.all?(fn item ->
    item < Enum.at(row, pos)
  end)
  left or right
end

check_column_visibility = fn column, pos ->
  top = Enum.slice(column, 0..pos-1)
  |> Enum.all?(fn item ->
    item < Enum.at(column, pos)
  end)
  bottom = Enum.slice(column, pos+1..length(column))
  |> Enum.all?(fn item ->
    item < Enum.at(column, pos)
  end)
  top or bottom
end

_get_position = fn table, x, y ->
  Enum.at(table, x) |> Enum.at(y)
end

is_visible = fn table, x, y ->
  cond do
    x == 0 or y == 0 ->
      true
    y == length(Enum.at(table, 0)) - 1 or x == length(table) - 1 ->
      true
    true ->
      check_row_visibility.(get_row.(table, x), y) or check_column_visibility.(get_column.(table, y), x)
  end
end
table = to_table.(data)
Enum.map(Enum.to_list(0..length(Enum.at(table, 0))-1), fn x ->
  Enum.map(Enum.to_list(0..length(table)-1), fn y ->
    is_visible.(table, x, y)
  end)
  |> Enum.count(fn item -> item == true end)
end)
|> Enum.sum()
|> IO.inspect()
