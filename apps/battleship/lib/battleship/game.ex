defmodule Battleship.Game do

  @enforce_keys [:squares]
  defstruct [squares: nil, scores: %{}, winner: nil]

  alias Battleship.{Game, Square}

  def new(size) do
    squares = 0..(size - 1)
              |> Enum.map(&make_squares_horizontally(&1, size))

    %Game{squares: squares}
  end

  defp make_squares_horizontally(x, size) do
    0..(size - 1)
    |> Enum.map(fn y -> Square.new(x, y) end)
  end
end
