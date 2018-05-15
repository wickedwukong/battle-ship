defmodule BattleshipHallWeb.GameController do
  use BattleshipHallWeb, :controller

  plug(:require_player)

  def new(conn, _params) do
    conn
    |> assign(:game_name, "game_name")
    |> assign(:auth_token, generate_auth_token(conn))
    |> render("new.html")
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
