require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require 'pry'

RSpec.describe Turn do
  describe 'Basic Type Turn' do
    before(:each) do
      @card1 = Card.new(:heart, 'Jack', 11)
      @card2 = Card.new(:heart, '10', 10)
      @card3 = Card.new(:heart, '9', 9)
      @card4 = Card.new(:diamond, 'Jack', 11)
      @card5 = Card.new(:heart, '8', 8)
      @card6 = Card.new(:diamond, 'Queen', 12)
      @card7 = Card.new(:heart, '3', 3)
      @card8 = Card.new(:diamond, '2', 2)
      @deck1 = Deck.new([@card1, @card2, @card5, @card8])
      @deck2 = Deck.new([@card3, @card4, @card6, @card7])
      @player1 = Player.new('Megan', @deck1)
      @player2 = Player.new('Aurora', @deck2)
      @turn = Turn.new(@player1, @player2)
    end

    it 'is an instance of Turn' do
      expect(@turn).to be_a(Turn)
    end

    it 'returns the appropriate turn #type' do
      expect(@turn.type).to eq(:basic)
    end

    it '#winner returns accurately for basic turn' do
      expect(winner = @turn.winner).to eq(@player1)
    end

    it '#pile_cards for basic turn' do
      @turn.pile_cards
      expect(@turn.spoils_of_war).to eq([@card1, @card3])
    end

    it "#award_spoils to the winner" do
      winner = @turn.winner
      @turn.pile_cards
      @turn.award_spoils(winner)
      #binding.pry
      expect(@player1.deck.cards).to eq([@card2, @card5, @card8, @card1, @card3])
    end
  end

  describe 'War Type Turn' do
    before(:each) do
      @card1 = Card.new(:heart, 'Jack', 11)
      @card2 = Card.new(:heart, '10', 10)
      @card3 = Card.new(:heart, '9', 9)
      @card4 = Card.new(:diamond, 'Jack', 11)
      @card5 = Card.new(:heart, '8', 8)
      @card6 = Card.new(:diamond, 'Queen', 12)
      @card7 = Card.new(:heart, '3', 3)
      @card8 = Card.new(:diamond, '2', 2)
      @deck1 = Deck.new([@card1, @card2, @card5, @card8])
      @deck2 = Deck.new([@card4, @card3, @card6, @card7])
      @player1 = Player.new('Megan', @deck1)
      @player2 = Player.new('Aurora', @deck2)
      @turn = Turn.new(@player1, @player2)
    end

    it 'is an instance of Turn' do
      expect(@turn).to be_a(Turn)
    end

    it 'returns the appropriate turn type' do
      expect(@turn.type).to eq(:war)
    end

    it '#winner returns accurately for war turn' do
      expect(winner = @turn.winner).to eq(@player2)
    end

    it '#pile_cards for war turn' do
      @turn.pile_cards
      expect(@turn.spoils_of_war).to eq([@card1, @card4, @card2, @card3, @card5, @card6])
    end

    it "#award_spoils to the winner" do
      winner = @turn.winner
      @turn.pile_cards
      @turn.award_spoils(winner)
      # require "pry"; binding.pry
      expect(@player1.deck.cards).to eq([@card8])
      expect(@player2.deck.cards).to eq([@card7, @card1, @card4, @card2, @card3, @card5, @card6])
    end
  end


  describe 'MAD Type Turn' do
    before(:each) do
      @card1 = Card.new(:heart, 'Jack', 11)
      @card2 = Card.new(:heart, '10', 10)
      @card3 = Card.new(:heart, '9', 9)
      @card4 = Card.new(:diamond, 'Jack', 11)
      @card5 = Card.new(:heart, '8', 8)
      @card6 = Card.new(:diamond, '8', 8)
      @card7 = Card.new(:heart, '3', 3)
      @card8 = Card.new(:diamond, '2', 2)
      @deck1 = Deck.new([@card1, @card2, @card5, @card8])
      @deck2 = Deck.new([@card4, @card3, @card6, @card7])
      @player1 = Player.new('Megan', @deck1)
      @player2 = Player.new('Aurora', @deck2)
      @turn = Turn.new(@player1, @player2)
    end

    it 'is an instance of Turn' do
      expect(@turn).to be_a(Turn)
    end

    it 'returns the appropriate turn type' do
      expect(@turn.type).to eq(:mutually_assured_destruction)
    end

    it '#winner returns accurately for MAD turn' do
      expect(winner = @turn.winner).to eq("No Winner")
    end

    it '#pile_cards does not shovel cards into spoils_of_war' do
      @turn.pile_cards
      expect(@turn.spoils_of_war).to eq([])
    end

    it "can verify cards removed by MAD type #pile_cards" do
      @turn.pile_cards
      expect(@player1.deck.cards).to eq([@card8])
      expect(@player2.deck.cards).to eq([@card7])
    end
  end
end
