defmodule Bingo do
  use Application

  def start(_type, _args) do
    buzzwords_file_path =
      "../data/buzzwords.csv"
      |> Path.expand(__DIR__)

    children = [
      %{
        id: Bingo.BuzzwordsCache,
        start: {Bingo.BuzzwordsCache, :start_link, [[buzzwords_file_path]]}
      }
    ]

    opts = [strategy: :one_for_one, name: Bingo.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def hello do
    :world
  end
end
