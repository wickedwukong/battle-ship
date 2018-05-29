defmodule TicTacToe.GameServer do
  use GenServer

  alias TicTacToe.Game

  @timeout :timer.hours(3)

  # client interface
  def start_link(game_name) do
    GenServer.start_link(
      __MODULE__,
      game_name,
      name: via_tuple(game_name)
    )
  end

  def summary(game_name) do
    GenServer.call(via_tuple(game_name), :summary)
  end

  def mark(game_name, %{x: x, y: y}, player) do
    GenServer.call(via_tuple(game_name), {:mark, %{x: x, y: y}, player})
  end

  def game_pid(game_name) do
    game_name
    |> via_tuple()
    |> GenServer.whereis()
  end

  def via_tuple(game_name) do
    {:via, Registry, {TicTacToe.GameRegistry, game_name}}
  end

  # server callback code
  def init(game_name) do
    game =
      case :ets.lookup(:games_table, game_name) do
        [] ->
          game = Game.new(game_name)
          :ets.insert(:games_table, {game_name, game})
          game

        [{^game_name, game}] ->
          game
      end

    {:ok, game, @timeout}
  end

  def handle_call({:mark, %{x: x, y: y}, player}, _from, game) do
    new_game = Game.mark(game, %{x: x, y: y}, player)

    :ets.insert(:games_table, {my_game_name, new_game})
    {:reply, summarize(new_game), new_game, @timeout}
  end

  def handle_call(:summary, _from, game) do
    {:reply, summarize(game), game, @timeout}
  end

  def summarize(game) do
    summary = %{
      game_name: game.game_name,
      squares: game.squares,
      winner: game.winner
    }
  end

  defp my_game_name do
    Registry.keys(TicTacToe.GameRegistry, self()) |> List.first()
  end
end
