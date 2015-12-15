defmodule BlackMagic21.DeckTest do
  use ExUnit.Case, async: true

  alias BlackMagic21.Deck
  alias BlackMagic21.Deck.Card

  test "new deck contains 52 cards" do
    assert Deck.new() |> length() == 52
  end

  test "deck contains 13 cards of each suit" do
    assert Deck.new()
    |> Enum.group_by(&(&1.suit))
    |> Map.values()
    |> Enum.map(&Enum.count/1)
    |> Enum.uniq()
    == [13]
  end

  test "number ranks evaluate to their number" do
    assert Deck.numbers
    |> Enum.map(fn(n) -> Deck.eval(%Card{rank: n, suit: :hearts}) end)
    == Deck.numbers
  end

  test "face ranks evalutate to 10, ace eval to 11 or " do
    assert Deck.faces
    |> Enum.map(fn(f) -> Deck.eval(%Card{rank: f, suit: :hearts}) end)
    |> Enum.uniq()
    == [10, {1, 11}]
  end

  test "evaluating a hand returns a tuple with an entry for each value the ace can take" do
    refute true
  end
end
