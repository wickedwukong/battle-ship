defmodule Battleship.GameSupervisor do
  use DynamicSupervisor

  alias Battleship.GameServer

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_game(game_name, size) do
    child_spec = %{
      id: GameServer,
      start: {GameServer, :start_link, [game_name, size]},
      restart: :transient
    }

    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end
end
