defmodule BuzzwordsCacheTest do
  use ExUnit.Case, async: true
  doctest TicTacToe.BuzzwordsCache

  alias TicTacToe.BuzzwordsCache

  test "give the cached buzzwords" do
    "buzzwords_test.csv"
    |> Path.expand(__DIR__)
    |> BuzzwordsCache.start_link()

    cached_buzzwords = BuzzwordsCache.get_buzzwords()

    assert %{phrase: _, points: _} = List.first(cached_buzzwords)
  end
end
