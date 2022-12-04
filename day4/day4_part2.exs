{:ok, body} = File.read('section_pairs.txt')

list_to_range = fn list ->
  {range_start, _} = Enum.at(list, 0) |> Integer.parse()
  {range_end, _} = Enum.at(list, 1) |> Integer.parse()
  range_start..range_end
end

contained? = fn s1, s2 ->
  not Range.disjoint?(list_to_range.(s1), list_to_range.(s2))
end

body
|> String.split("\n")
|> Enum.map(fn line ->
  sections = String.split(line, ",")
  contained?.(Enum.at(sections, 0) |> String.split("-"), Enum.at(sections, 1) |> String.split("-"))
end)
|> Enum.filter(fn contained ->
  contained == true
end)
|> Enum.count()
|> IO.inspect()
