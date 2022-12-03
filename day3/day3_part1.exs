{:ok, body} = File.read('rucksack.txt')

value_of = fn char ->
  values = Enum.zip(1..52, String.graphemes("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))
  {result, _} = Enum.filter(values, fn {_a, b} ->
    char == b
  end)
  |> List.first()
  result
end

body
|> String.split("\n")
|> Enum.slice(0..-2)
|> Enum.map(fn line ->
  {first, second} = String.split_at(line, Kernel.trunc(String.length(line)/2))
  value_of.(String.myers_difference(first, second)[:eq])
end)
|> Enum.sum()
|> IO.inspect()
