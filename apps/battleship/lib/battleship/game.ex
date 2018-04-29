defmodule Battleship.Game do
  @enforce_keys [:squares, :game_name]
  defstruct squares: nil, scores: %{}, winner: nil, game_name: nil

  alias Battleship.{Game, Square}

  def new(game_name, size) do
    squares =
      0..(size - 1)
      |> Enum.map(&make_squares_horizontally(&1, size))

    %Game{squares: squares, game_name: game_name}
  end

  defp make_squares_horizontally(x, size) do
    0..(size - 1)
    |> Enum.map(fn y -> Square.new(x, y) end)
  end
end
