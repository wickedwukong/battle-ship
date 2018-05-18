defmodule PlayerTest do
  use ExUnit.Case, async: true
  doctest TicTacToe.Player

  alias TicTacToe.Player

  test "create a player with name" do
    player = Player.new("Nelson", :x)

    assert %Player{name: "Nelson", piece: :x} == player
  end
end
