defmodule GameServerTest do
  use ExUnit.Case, async: true

  doctest TicTacToe.GameServer

  alias TicTacToe.{GameServer, Game, Player}

  test "spawning a game server process" do
    game_name = generate_game_name()

    assert {:ok, _pid} = GameServer.start_link(game_name)
  end

  test "getting a pid for a game name" do
    game_name = generate_game_name()
    {:ok, pid} = GameServer.start_link(game_name)

    assert pid = GameServer.game_pid(game_name)
  end

  test "getting a summary" do
    game_name = generate_game_name()

    {:ok, _pid} = GameServer.start_link(game_name)

    summary = GameServer.summary(game_name)

    assert game_name == summary.game_name
    assert nil == summary.winner
    assert %{} == summary.scores
    assert 3 == Enum.count(summary.squares)
  end

  test "a game process is registered under a unique name" do
    game_name = generate_game_name()

    assert {:ok, _pid} = GameServer.start_link(game_name)
    assert {:error, {:already_started, _pid}} = GameServer.start_link(game_name)
  end

  test "marking squares" do
    game_name = generate_game_name()

    {:ok, _pid} = GameServer.start_link(game_name)

    player = Player.new("Nicole", :x)

    _summary = GameServer.mark(game_name, %{x: 0, y: 0}, player)
    _summary = GameServer.mark(game_name, %{x: 0, y: 1}, player)
    summary = GameServer.mark(game_name, %{x: 0, y: 2}, player)

    assert Map.get(summary.scores, player.name)
    assert summary.winner == player
  end

  test "store initial state when it started" do
    game_name = generate_game_name()

    GameServer.start_link(game_name)

    assert [{^game_name, game}] = :ets.lookup(:games_table, game_name)

    assert game_name == game.game_name
    assert nil == game.winner
    assert %{} == game.scores
    assert 3 == Enum.count(game.squares)
  end

  test "restore a game if there is an existing one stored in ets" do
    game_name = generate_game_name()
    game = Game.new(game_name)

    :ets.insert(:games_table, {game_name, game})

    GameServer.start_link(game_name)

    summary = GameServer.summary(game_name)

    assert game_name == summary.game_name
    assert 3 == Enum.count(summary.squares)
    assert nil == summary.winner
    assert %{} == summary.scores
  end

  defp generate_game_name do
    "game-#{:rand.uniform(1_000_000)}"
  end
end
