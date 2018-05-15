defmodule TicTacToe do
  use Application

  def start(_type, _args) do
    buzzwords_file_path =
      "../data/buzzwords.csv"
      |> Path.expand(__DIR__)

    children = [
      {Registry, keys: :unique, name: TicTacToe.GameRegistry},
      %{
        id: TicTacToe.BuzzwordsCache,
        start: {TicTacToe.BuzzwordsCache, :start_link, [[buzzwords_file_path]]}
      },
      %{
        id: TicTacToe.GameSupervisor,
        start: {TicTacToe.GameSupervisor, :start_link, [[]]}
      }
    ]

    :ets.new(:games_table, [:public, :named_table])

    opts = [strategy: :one_for_one, name: TicTacToe.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def hello do
    :world
  end
end
