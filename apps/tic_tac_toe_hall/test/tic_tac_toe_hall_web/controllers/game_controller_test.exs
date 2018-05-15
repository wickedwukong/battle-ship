defmodule TicTacToeHallWeb.GameControllerTest do
  use TicTacToeHallWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    # assert html_response(conn, 302) =~ "Welcome to Phoenix!"
    assert redirected_to(conn, 302) =~ "/sessions/new"
  end
end
