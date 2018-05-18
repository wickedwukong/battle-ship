defmodule TicTacToeHallWeb.GameChannel do
  use TicTacToeHallWeb, :channel

  alias TicTacToe.GameServer

  def join("games:" <> game_name, _params, socket) do
    case GameServer.game_pid(game_name) do
      pid when is_pid(pid) ->
        send(self(), {:after_join, game_name})
        {:ok, socket}

      nil ->
        {:error, %{reason: "Game does not exist: #{game_name}"}}
    end
  end

  def handle_info({:after_join, game_name}, socket) do
    push(socket, "game_summary", %{game_summary: "This is a place holder for game summary"})

    {:noreply, socket}
  end

  def handle_in("mark_square", %{"square_x" => x, "square_y" => y}, socket) do
    "games:" <> game_name = socket.topic

    case GameServer.game_pid(game_name) do
      pid when is_pid(pid) ->
        # TODO: implement mark square
        GameServer.mark_game(game_name, %{x: x, y: y}, current_player(socket))

        broadcast!(socket, "game_summary", %{
          game_summary: "This is a place holder for game summary"
        })

        {:reply, :ok, socket}

      nil ->
        {:error, %{reason: "Game does not exist: #{game_name}"}}
    end
  end

  defp current_player(socket) do
    socket.assigns.current_player
  end
end
