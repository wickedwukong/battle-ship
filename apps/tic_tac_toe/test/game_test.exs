defmodule GameTest do
  use ExUnit.Case, async: true
  doctest TicTacToe.Game

  alias TicTacToe.{Game, Square}

  test "create new game with a specfied size" do
    game = Game.new("game-name-foo", 3)

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
end
