defmodule Battleship.GameServer do
  use GenServer

  alias Battleship.Game

  @timeout :timer.hours(3)

  # client code
  def start_link(game_name, size) do
    GenServer.start_link(
      __MODULE__,
      {game_name, size},
      name: {:via, Registry, {Battleship.GameRegistry, game_name}}
    )
  end

  # server code
  def init({game_name, size}) do
    game = Game.new(game_name, size)
    :ets.insert(:games_table, {game_name, game})
    {:ok, game, @timeout}
  end
end
