{:ok, data} = File.read("datastream.txt")

defmodule Signal do
  @signal_size 14
  def process_char(char, processed_chars, input_size) do
    if input_size < @signal_size and char not in processed_chars do
      {input_size+1, processed_chars ++ [char]}
    else if input_size < @signal_size and char in processed_chars do
        clean_list = List.to_string(processed_chars)
        |> String.split(char)
        |> Enum.at(1)
        |> String.split("")
        |> Enum.slice(1..-2)
        {length(clean_list)+1, clean_list++[char]}
      end
    end
  end

  def process_input([char|rest], processed_chars \\ [], input_size \\ 0, position \\ 0) do
    if input_size == @signal_size do
      position
    else
      {size, chars} = process_char(char, processed_chars, input_size)
      process_input(rest, chars, size, position+1)
    end
  end
end

data
|> String.split("")
|> Enum.slice(1..-2)
|> Signal.process_input()
|> IO.inspect()
