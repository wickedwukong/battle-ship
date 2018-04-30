defmodule Battleship do
  use Application

  def start(_type, _args) do
    buzzwords_file_path =
      "../data/buzzwords.csv"
      |> Path.expand(__DIR__)

    children = [
      {Registry, keys: :unique, name: Battleship.GameRegistry},
      %{
        id: Battleship.BuzzwordsCache,
        start: {Battleship.BuzzwordsCache, :start_link, [[buzzwords_file_path]]}
      }
    ]

    :ets.new(:games_table, [:public, :named_table])

    opts = [strategy: :one_for_one, name: Battleship.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def hello do
    :world
  end
end
