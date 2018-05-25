defmodule PlayerTest do
  use ExUnit.Case, async: true
  doctest TicTacToe.Player

  alias TicTacToe.Player

  test "create a player with name" do
    player = Player.new("Nelson", :X)

    assert %Player{name: "Nelson", piece: :X} == player

    another_player = Player.new("Nelson", :O)

    assert %Player{name: "Nelson", piece: :O} == another_player
  end
end
