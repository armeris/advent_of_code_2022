# A - Rock (1)
# B - Paper (2)
# C - Scissors (3)
# X - Loss
# Y - Draw
# Z - Win
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

  def calculate_new({he, me}) do
    case he do
      "A" -> case me do
        "X" -> calculate({"A","Z"})
        "Y" -> calculate({"A","X"})
        "Z" -> calculate({"A","Y"})
      end
      "B" -> case me do
        "X" -> calculate({"B","X"})
        "Y" -> calculate({"B","Y"})
        "Z" -> calculate({"B","Z"})
      end
      "C" -> case me do
        "X" -> calculate({"C","Y"})
        "Y" -> calculate({"C","Z"})
        "Z" -> calculate({"C","X"})
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
  RPS.calculate_new({he,me})
end)
|> Enum.sum()
|> IO.inspect()
