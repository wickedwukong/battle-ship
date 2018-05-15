defmodule TicTacToe.Player do
  @enforce_key [:name]
  defstruct [:name]

  def new(name) do
    %TicTacToe.Player{name: name}
  end
end
