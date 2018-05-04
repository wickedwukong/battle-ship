defmodule GameSupervisorTest do
  use ExUnit.Case, async: true

  alias Battleship.{GameServer, GameSupervisor}

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

      assert{:error, {:already_started, ^pid}} = GameSupervisor.start_game(game_name, 5)
    end
  end
end
