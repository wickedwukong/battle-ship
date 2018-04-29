defmodule BattleShip do
  use Application

  def start(_type, _args) do
    buzzwords_file_path =
      "../data/buzzwords.csv"
      |> Path.expand(__DIR__)

    children = [
      %{
        id: BattleShip.BuzzwordsCache,
        start: {BattleShip.BuzzwordsCache, :start_link, [[buzzwords_file_path]]}
      }
    ]

    opts = [strategy: :one_for_one, name: BattleShip.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def hello do
    :world
  end
end
