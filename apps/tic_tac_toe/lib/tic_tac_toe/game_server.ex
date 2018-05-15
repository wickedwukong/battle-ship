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

  def handle_call(:summary, _from, game) do
    summary = %{
      game_name: game.game_name,
      scores: game.scores,
      squares: game.squares,
      winner: game.winner
    }

    {:reply, summary, game, @timeout}
  end
end
