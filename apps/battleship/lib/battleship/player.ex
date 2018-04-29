defmodule Battleship.Player do
  @enforce_key [:name]
  defstruct [:name]

  def new(name) do
    %Battleship.Player{name: name}
  end
end
