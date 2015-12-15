defmodule BlackMagic21.Deck do
  defmodule Card do
    defstruct ~w(rank suit)a
  end

  @faces    ~w(J Q K A)
  @numbers  Enum.to_list(2..10)
  @ranks    @numbers ++ @faces
  @suits    ~w(clubs diamonds hearts spades)a

  def draw(deck) do
    [card | rest] = deck
    {card, rest}
  end

  def eval(hand) when is_list(hand) do
    Enum.map(hand, &eval(&1))
    |> interpolate_ace_values()
    |> Enum.map(&Enum.sum/1)
    |> List.to_tuple()
  end

  def eval(card = %Card{}) do
    eval(card.rank)
  end

  def eval(rank) when rank in @faces do
    case rank do
      "A" -> {1, 11}
      _   -> 10
    end
  end

  def eval(rank) when rank in @numbers do
    rank
  end

  def interpolate_ace_values(result) do
    [1, 11] |> Enum.map(&interpolate_ace_values(result, &1))
  end

  def interpolate_ace_values(result, val) do
    Enum.map(result, fn(x) ->
      case is_tuple(x) do
        true -> val
        _    -> x
      end
    end)
  end

  def new do
    for r <- ranks, s <- suits do
      %Card{rank: r, suit: s}
    end |> shuffle()
  end

  def shuffle(deck) do
    deck |> Enum.shuffle()
  end

  def faces,   do:  @faces
  def numbers, do:  @numbers
  def ranks,   do:  @ranks
  def suits,   do:  @suits
end
