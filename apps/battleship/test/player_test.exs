defmodule PlayerTest do
  use ExUnit.Case, async: true
  doctest Battleship.Player

  alias Battleship.Player

  test "create a player with name" do
    player = Player.new("Nelson")

    assert %Player{name: "Nelson"} == player
  end
end
