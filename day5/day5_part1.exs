{:ok, body} = File.read('crates.txt')
[crates, moves] = String.split(body, "\n\n")

defmodule CrateMovements do
  def process_moves(moves) do
    moves
    |> String.split("\n")
    |> Enum.map(&Regex.scan(~r[move (\d+) from (\d+) to (\d+)], &1, []))
    |> Enum.map(&List.flatten(&1))
    |> Enum.map(fn filter ->
      [_, number, from, to] = filter
      {number, _} = Integer.parse(number)
      {from, _} = Integer.parse(from)
      {to, _} = Integer.parse(to)
      %{number: number , from: from-1, to: to-1}
    end)
  end

  def process_crates(crates) do
    table = crates
    |> String.split("\n")
    |> Enum.slice(0..-2)
    |> Enum.map(fn line ->
      String.to_charlist(line)
    end)
    |> Enum.map(fn line ->
      Enum.chunk_every(line, 4)
    end)
    |> Enum.map(fn row ->
      Enum.map(row, fn item ->
        Kernel.inspect(item)
        |> String.trim("'")
        |> String.trim()
        |> String.trim("[")
        |> String.trim("]")
      end)
    end)

    piles = [Enum.map(table, fn row ->
      Enum.at(row,8)
    end)|[]]
    piles = [Enum.map(table, fn row ->
      Enum.at(row,7)
    end)|piles]
    piles = [Enum.map(table, fn row ->
      Enum.at(row,6)
    end)|piles]
    piles = [Enum.map(table, fn row ->
      Enum.at(row,5)
    end)|piles]
    piles = [Enum.map(table, fn row ->
      Enum.at(row,4)
    end)|piles]
    piles = [Enum.map(table, fn row ->
      Enum.at(row,3)
    end)|piles]
    piles = [Enum.map(table, fn row ->
      Enum.at(row,2)
    end)|piles]
    piles = [Enum.map(table, fn row ->
      Enum.at(row,1)
    end)|piles]
    piles = [Enum.map(table, fn row ->
      Enum.at(row,0)
    end)|piles]
    piles
    |> Enum.map(fn row ->
      Enum.filter(row, fn item ->
        item != ""
      end)
    end)

  end

  def move_one(piles, from, to) do
    [elem|rest] = Enum.at(piles, from)
      piles = List.replace_at(piles, from, rest)
      piles = List.replace_at(piles, to, [elem|Enum.at(piles,to)])
      piles
  end

  def move(piles, from, to, number) do
    cond do
      number == 1 -> move_one(piles,from,to)
      number > 1 ->
        piles = move_one(piles, from, to)
        move(piles, from, to, number - 1)
    end
  end

  def make_move(movement, piles) do
    move(piles, movement[:from], movement[:to], movement[:number])
  end

  def make_moves([], piles) do
    piles
  end

  def make_moves([movement|rest], piles) do
    make_moves(rest,make_move(movement, piles))
  end
end


piles = CrateMovements.process_crates(crates)
movements = CrateMovements.process_moves(moves)

piles = CrateMovements.make_moves(movements, piles)

piles
|> Enum.map(fn line ->
  Enum.at(line, 0)
end)
|> Enum.join()
|> IO.inspect()
