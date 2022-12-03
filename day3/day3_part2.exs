{:ok, body} = File.read('rucksack.txt')

value_of = fn char ->
  values = Enum.zip(1..52, String.graphemes("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))
  {result, _} = Enum.filter(values, fn {_a, b} ->
    char == b
  end)
  |> List.first()
  result
end

intersect = fn list1, list2, list3 ->
    Enum.filter(String.to_charlist(list1), fn char -> (char in String.to_charlist(list2)) and (char in String.to_charlist(list3)) end)
    |> Enum.uniq()
end

body
|> String.split("\n")
|> Enum.slice(0..-2)
|> Enum.chunk_every(3)
|> Enum.map(fn set ->
  intersect.(Enum.at(set, 0), Enum.at(set, 1), Enum.at(set, 2))
  |> List.to_string()
  |> value_of.()
end)
|> Enum.sum()
|> IO.inspect()
