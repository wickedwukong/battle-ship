defmodule TicTacToe.Game do
  @enforce_keys [:squares, :game_name]
  defstruct squares: nil, scores: %{}, winner: nil, game_name: nil

  alias TicTacToe.{Game, Square}

  def new(game_name) do
    squares =
      for(
        x <- 0..2,
        y <- 0..2,
        do: Square.new(x, y)
      )
      |> Enum.chunk(3)

    %Game{squares: squares, game_name: game_name}
  end
end
