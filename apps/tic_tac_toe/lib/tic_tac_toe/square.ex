defmodule TicTacToe.Square do
  @enforce_key [:x, :y]
  defstruct [:x, :y, :marked_by]

  alias TicTacToe.Square

  def new(x, y) do
    %Square{x: x, y: y}
  end
end
