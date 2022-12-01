{:ok, body} = File.read('elf_calories_input.txt')

body
|> String.split("\n\n")
|> Enum.map(fn elf ->
  String.split(elf, "\n")
  |> Enum.filter(fn a -> a != "" end)
  |> Enum.map(fn a ->
    {res, _} = Integer.parse(a)
    res
  end)
  |> Enum.sum()
end)
|> Enum.sort()
|> Enum.slice(-3, 3)
|> Enum.sum()
|> IO.inspect()
