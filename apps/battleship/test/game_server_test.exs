defmodule GameServerTest do
  use ExUnit.Case, async: true

  doctest Battleship.GameServer

  alias Battleship.GameServer

  test "spawning a game server process" do
    game_name = generate_game_name()
    size = 3

    assert {:ok, _pid} = GameServer.start_link(game_name, size)
  end

  defp generate_game_name do
    "game-#{:rand.uniform(1_000_000)}"
  end
end
