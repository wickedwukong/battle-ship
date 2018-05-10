defmodule BattleshipHallWeb.GameController do
  use BattleshipHallWeb, :controller

  plug(:require_player)

  def new(conn, _params) do
    render(conn, "new.html")
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
end
