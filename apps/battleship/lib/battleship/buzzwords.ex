defmodule Battleship.Buzzwords do
  def read_buzzwords(file_path) do
    file_path
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [phrase, points] ->
      %{phrase: phrase, points: String.to_integer(points)}
    end)
  end
end
