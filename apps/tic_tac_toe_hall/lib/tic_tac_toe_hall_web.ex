defmodule TicTacToeHallWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use TicTacToeHallWeb, :controller
      use TicTacToeHallWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: TicTacToeHallWeb
      import Plug.Conn
      import TicTacToeHallWeb.Router.Helpers
      import TicTacToeHallWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/tic_tac_toe_hall_web/templates",
        namespace: TicTacToeHallWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import TicTacToeHallWeb.Router.Helpers
      import TicTacToeHallWeb.ErrorHelpers
      import TicTacToeHallWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import TicTacToeHallWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
