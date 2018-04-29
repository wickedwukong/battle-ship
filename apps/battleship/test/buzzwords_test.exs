defmodule BuzzwordsTest do
  use ExUnit.Case, async: true
  doctest Battleship.Buzzwords

  alias Battleship.Buzzwords

  test "read buzzwords csv files" do
    buzzwords =
      "buzzwords_test.csv"
      |> Path.expand(__DIR__)
      |> Buzzwords.read_buzzwords()

    assert [%{phrase: "Above My Pay Grade", points: 400}, %{phrase: "Action Item", points: 350}] =
             buzzwords
  end
end
