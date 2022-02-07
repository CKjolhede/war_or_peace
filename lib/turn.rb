require './lib/player'
require './lib/deck'
require './lib/card'
require 'pry'

class Turn
  attr_reader :player1, :player2, :spoils_of_war
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.deck.cards[0].rank != @player2.deck.cards[0].rank
      :basic
    elsif @player1.deck.cards[2].rank != @player2.deck.cards[2].rank
      :war
    else
      :mutually_assured_destruction
    end
  end

  def winner
     if @player1.deck.cards[0].rank > @player2.deck.cards[0].rank
        @player1
      elsif @player1.deck.cards[0].rank < @player2.deck.cards[0].rank
        @player2
      elsif @player1.deck.cards[2].rank > @player2.deck.cards[2].rank
        @player1
      elsif @player1.deck.cards[2].rank < @player2.deck.cards[2].rank
        @player2
      else
       "No Winner"
     end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << @player1.deck.cards.shift
      @spoils_of_war << @player2.deck.cards.shift
    elsif type == :war
      3.times do
        @spoils_of_war << @player1.deck.cards.shift
        @spoils_of_war << @player2.deck.cards.shift
      end
    else type == :mutually_assured_destruction
      3.times do
        @player1.deck.cards.shift
        @player2.deck.cards.shift
      end
    end
  end

  def award_spoils(winner)
    if winner.is_a?(Player)
    # p @spoils_of_war.count
    winner.deck.cards << @spoils_of_war
    # p winner.deck.cards.count
    winner.deck.cards.flatten!
    # p winner.deck.cards.count
    else
    end
  end
end
