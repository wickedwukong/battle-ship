defmodule GameServerTest do
  use ExUnit.Case, async: true

  doctest Battleship.GameServer

  alias Battleship.GameServer

  test "spawning a game server process" do
    game_name = generate_game_name()

    assert {:ok, _pid} = GameServer.start_link(game_name, 3)
  end

  test "a game process is registered under a unique name" do
    game_name = generate_game_name()

    assert {:ok, _pid} = GameServer.start_link(game_name, 3)
    assert {:error, {:already_started, _pid}} = GameServer.start_link(game_name, 3)
  end

  test "store initial state when it started" do
    game_name = generate_game_name()

    GameServer.start_link(game_name, 3)

    assert [{^game_name, game}] = :ets.lookup(:games_table, game_name)

    assert game_name == game.game_name
    assert nil == game.winner
    assert %{} == game.scores
    assert 3 == Enum.count(game.squares)
  end

  defp generate_game_name do
    "game-#{:rand.uniform(1_000_000)}"
  end
end
