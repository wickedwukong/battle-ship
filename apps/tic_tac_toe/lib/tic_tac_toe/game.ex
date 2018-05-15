defmodule TicTacToe.Game do
  @enforce_keys [:squares, :game_name]
  defstruct squares: nil, scores: %{}, winner: nil, game_name: nil

  alias TicTacToe.{Game, Square}

  def new(game_name, size) do
    squares =
      for(
        x <- 0..(size - 1),
        y <- 0..(size - 1),
        do: Square.new(x, y)
      )
      |> Enum.chunk(size)

    %Game{squares: squares, game_name: game_name}
  end
end
