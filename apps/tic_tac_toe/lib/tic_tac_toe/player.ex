defmodule TicTacToe.Player do
  @enforce_key [:name, :piece]
  defstruct [:name, :piece]

  def new(name, piece = :X) do
    %TicTacToe.Player{name: name, piece: piece}
  end

  def new(name, piece = :O) do
    %TicTacToe.Player{name: name, piece: piece}
  end
end
