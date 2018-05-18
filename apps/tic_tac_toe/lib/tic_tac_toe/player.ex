defmodule TicTacToe.Player do
  @enforce_key [:name, :piece]
  defstruct [:name, :piece]

  def new(name, :x) do
    %TicTacToe.Player{name: name, piece: :x}
  end

  def new(name, :y) do
    %TicTacToe.Player{name: name, piece: :y}
  end
end
