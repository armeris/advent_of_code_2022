# A - X - Rock (1)
# B - Y - Paper (2)
# C - Z - Scissors (3)
# Win 6 - Draw 3 - Loss 0

defmodule RPS do
  def calculate({he, me}) do
    case he do
      "A" -> case me do
        "X" -> 4
        "Y" -> 8
        "Z" -> 3
      end
      "B" -> case me do
        "X" -> 1
        "Y" -> 5
        "Z" -> 9
      end
      "C" -> case me do
        "X" -> 7
        "Y" -> 2
        "Z" -> 6
      end
    end
  end
end

{:ok, body} = File.read('strategy_guide.txt')

body
|> String.split("\n")
|> Enum.slice(0..-2)
|> Enum.map(fn line ->
  [he|[me|_]] = String.split(line, " ")
  RPS.calculate({he,me})
end)
|> Enum.sum()
|> IO.inspect()
