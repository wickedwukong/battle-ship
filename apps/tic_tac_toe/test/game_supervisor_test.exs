defmodule GameSupervisorTest do
  use ExUnit.Case, async: true

  alias TicTacToe.{GameServer, GameSupervisor}

  describe "start_game" do
    test "spawn a game server process" do
      game_name = "game-name-#{:rand.uniform(1000)}"
      assert {:ok, _pid} = GameSupervisor.start_game(game_name, 3)

      via = GameServer.via_tuple(game_name)
      assert GenServer.whereis(via) |> Process.alive?()
    end

    test "return an error if a game is already started" do
      game_name = "game-name-#{:rand.uniform(1000)}"
      assert {:ok, pid} = GameSupervisor.start_game(game_name, 3)

      assert {:error, {:already_started, ^pid}} = GameSupervisor.start_game(game_name, 5)
    end
  end

  describe "stop_game" do
    test "terminate game process normally and game state is deleted from ets" do
      game_name = "game-name-#{:rand.uniform(1000)}"
      {:ok, _pid} = GameSupervisor.start_game(game_name, 3)

      via = GameServer.via_tuple(game_name)
      assert :ok = GameSupervisor.stop_game(game_name)

      refute GenServer.whereis(via)

      assert [] = :ets.lookup(:games_table, game_name)
    end
  end
end
