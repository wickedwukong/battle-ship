defmodule PlayerTest do
  use ExUnit.Case, async: true
  doctest TicTacToe.Player

  alias TicTacToe.Player

  test "create a player with name" do
    player = Player.new("Nelson")

    assert %Player{name: "Nelson"} == player
  end
end
