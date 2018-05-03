defmodule GameSupervisorTest do
  use ExUnit.Case, async: true

  alias Battleship.{GameServer, GameSupervisor}

  test "spawn a game server process" do
    game_name = "game-name-#{:rand.uniform(1000)}"
    assert {:ok, _pid} = GameSupervisor.start_game(game_name, 3)

    via = GameServer.via_tuple(game_name)
    assert GenServer.whereis(via) |> Process.alive?()
  end
end
