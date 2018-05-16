defmodule TicTacToeHallWeb.GameController do
  use TicTacToeHallWeb, :controller
  alias TicTacToe.{GameSupervisor, GameServer}
  plug(:require_player)

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, _params) do
    game_name = TicTacToeHall.HaikuName.generate()

    case GameSupervisor.start_game(game_name) do
      {:ok, pid} ->
        redirect(conn, to: game_path(conn, :show, game_name))

      {:error, _error} ->
        conn
        |> put_flash(:error, "Failed to start a game: #{game_name}")
        |> redirect(to: session_path(conn, :new))
    end
  end

  def show(conn, %{"id" => game_name}) do
    case GameServer.game_pid(game_name) do
      pid when is_pid(pid) ->
        conn
        |> assign(:game_name, game_name)
        |> assign(:auth_token, generate_auth_token(conn))
        |> render("show.html")

      nil ->
        conn
        |> put_flash(:error, "No game is found for #{game_name}")
        |> redirect(to: game_path(conn, :new))
    end
  end

  defp require_player(conn, _opts) do
    if(get_session(conn, :current_player)) do
      conn
    else
      conn
      |> put_session(:return_to, conn.request_path)
      |> redirect(to: session_path(conn, :new))
      |> halt()
    end
  end

  defp generate_auth_token(conn) do
    current_player = get_session(conn, :current_player)
    Phoenix.Token.sign(conn, "player auth", current_player)
  end
end
