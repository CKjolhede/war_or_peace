require './lib/card'
require './lib/deck'
# require './war_and_peace_runner'
require 'pry'

class Player
  attr_reader :name, :deck

  def initialize(name, deck)
    @deck = deck
    @name = name
  end

  def has_lost?
    # deck.cards.count == 0
    if @deck.cards.count == 0
      true
    elsif @deck.cards.count < 2 && @turn_count != nil
      true
    else
      false
    end
  end
end
