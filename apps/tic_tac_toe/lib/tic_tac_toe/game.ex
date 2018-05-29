defmodule TicTacToe.Game do
  @enforce_keys [:squares, :game_name]
  defstruct squares: nil, winner: nil, game_name: nil

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
    marked_squares =
      game.squares
      |> List.flatten()
      |> Enum.map(&mark_selected_square(&1, x, y, player))
      |> Enum.chunk(3)

    %{game | squares: marked_squares} |> update_winner_if_there_is_one
  end

  defp update_winner_if_there_is_one(game) do
    lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    declared_winner = declare_winner(lines, List.flatten(game.squares), length(lines) - 1)

    # IO.inspect List.flatten(game.squares)

    %{game | winner: declared_winner}
  end

  defp declare_winner(lines, squares, index_of_lines) do
    [s1, s2, s3] = Enum.at(lines, index_of_lines)
    square_1 = squares |> Enum.at(s1)
    square_2 = squares |> Enum.at(s2)
    square_3 = squares |> Enum.at(s3)

    cond do
      (square_1.marked_by != nil) && (square_1.marked_by == square_2.marked_by) && (square_2.marked_by == square_3.marked_by) -> square_1.marked_by
      index_of_lines > 0 -> declare_winner(lines, squares, index_of_lines - 1)
      true -> nil
    end
  end

  defp mark_selected_square(square, x, y, player) do
    if square.x == x && square.y == y do
      %{square | marked_by: player}
    else
      square
    end
  end
end
