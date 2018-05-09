defmodule BattleshipHallWeb.SessionController do
  use BattleshipHallWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end
end
