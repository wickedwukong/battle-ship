defmodule BattleshipHallWeb.SessionController do
  use BattleshipHallWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"player" => %{"name" => name}}) do
    player = Battleship.Player.new(name)

    conn
    |> put_session(:current_player, player)
    |> redirect_back_or_to_new_game
  end

  defp redirect_back_or_to_new_game(conn) do
    return_to = get_session(conn, :return_to) || game_path(conn, :new)

    conn
    |> put_session(:return_to, nil)
    |> redirect(to: return_to)

  end
end
