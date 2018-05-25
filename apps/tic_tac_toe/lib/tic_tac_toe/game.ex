defmodule TicTacToe.Game do
  @enforce_keys [:squares, :game_name]
  defstruct squares: nil, scores: %{}, winner: nil, game_name: nil

  alias TicTacToe.{Game, Square, Player}

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

  def mark(%Game{} = game, %{x: x, y: y}, %Player{} = player) do
     marked_squares = game.sqaures
                        |> Enum.map(&mark_selected_square(&1, x, y, player))
  end

  defp mark_selected_square(square, x, y, player) do
    if (square.x == x && square.y == y)  do
      %{square | marked_by: player}
    else
      square
    end
  end
end
