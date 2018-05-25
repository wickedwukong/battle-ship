defmodule GameTest do
  use ExUnit.Case, async: true
  doctest TicTacToe.Game

  alias TicTacToe.{Game, Square, Player}

  test "create new game" do
    game = Game.new("game-name-foo")

    assert "game-name-foo" == game.game_name
    assert Enum.count(game.squares) == 3

    first_row = Enum.at(game.squares, 0)
    row_count = Enum.count(game.squares)
    column_count = Enum.count(first_row)

    assert row_count == 3
    assert row_count == column_count

    assert [Square.new(0, 0), Square.new(0, 1), Square.new(0, 2)] == first_row

    second_row = Enum.at(game.squares, 1)
    assert [Square.new(1, 0), Square.new(1, 1), Square.new(1, 2)] == second_row

    third_row = Enum.at(game.squares, 2)
    assert [Square.new(2, 0), Square.new(2, 1), Square.new(2, 2)] == third_row
  end

  test "mark game" do
    game =
      generate_game_name()
      |> Game.new()

    player = Player.new("ZhangSan", :X)
    new_game = Game.mark(game, %{x: 0, y: 0}, player)

    first_square = game.squares
                     |> Enum.at(0)
                     |> Enum.at(0)

    assert first_square.marked_by == player
  end

  defp generate_game_name do
    "game-#{:rand.uniform(1_000_000)}"
  end
end
