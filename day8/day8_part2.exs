{:ok, data} = File.read("input.txt")


defmodule Table do
  def to_table(data) do
    String.split(data, "\n")
    |> Enum.map(fn line ->
      String.split(line, "")
      |> Enum.slice(1..-2)
      |> Enum.map(fn item ->
        elem(Integer.parse(item), 0)
      end)
    end)
  end

  def get_row(table, row) do
    Enum.at(table, row)
  end

  def get_column(table, column) do
    Enum.map(table, fn row ->
      Enum.at(row, column)
    end)
    |> List.flatten()
  end

  def get_position(table, x, y) do
    Enum.at(table, x) |> Enum.at(y)
  end
end

defmodule Score do
  def get_score([], _item) do
    0
  end

  def get_score([f|rest], item) do
    cond do
      f < item ->
        1 + get_score(rest, item)
      f >= item ->
        1
    end
  end

  def get_row_score(row, pos) do
    left = case pos do
      0 -> 0
      _ -> Enum.slice(row, 0..pos-1)
      |> Enum.reverse()
      |> get_score(Enum.at(row, pos))
    end
    row_length = length(row)
    right = case pos do
      0 ->
        get_score(row, Enum.at(row, pos))
      ^row_length -> 0
      _ ->
        Enum.slice(row, pos+1..length(row))
        |> get_score(Enum.at(row, pos))
    end
    left * right
  end

  def get_column_score(column, pos) do
    top = case pos do
      0 -> 0
      _ -> Enum.slice(column, 0..pos-1)
      |> Enum.reverse()
      |> get_score(Enum.at(column, pos))
    end
    column_length = length(column)
    bottom = case pos do
      0 ->
        get_score(column, Enum.at(column, pos))
      ^column_length -> 0
      _ ->
        Enum.slice(column, pos+1..length(column))
        |> get_score(Enum.at(column, pos))
    end
    top * bottom
  end

  def get_table_score(table, x ,  y) do
    get_row_score(Table.get_row(table, x), y) * get_column_score(Table.get_column(table, y), x)
  end
end

table = Table.to_table(data)
Enum.map(Enum.to_list(0..length(Enum.at(table, 0))-1), fn x ->
  Enum.map(Enum.to_list(0..length(table)-1), fn y ->
    Score.get_table_score(table, x, y)
  end)
  |> Enum.max()
end)
|> Enum.max()
|> IO.inspect()
