defmodule BattleshipHallWeb.Router do
  use BattleshipHallWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", BattleshipHallWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", GameController, :new)

    resources("/games", GameController, only: [:new, :create, :show])

    resources("/sessions", SessionController, only: [:new, :create, :delete], singleton: true)
  end

  # Other scopes may use custom stacks.
  # scope "/api", BattleshipHallWeb do
  #   pipe_through :api
  # end
end
