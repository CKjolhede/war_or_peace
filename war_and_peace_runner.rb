require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'


class Game
  attr_reader :player1, :player2, :cards, :turn_count, :winner

  def initialize
    cards = make_cards
    deck_1 = Deck.new(cards.pop(26))
    deck_2 = Deck.new(cards)
    @player1 = Player.new("Megan", deck_1)
    @player2 = Player.new("Aurora", deck_2)
    @turn_count = 0
    # @winner = nil
  end

  def make_cards
    suits = [:spade, :club, :heart, :diamond]
    @cards_array = []
    suits.each do |suit|
      values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
      value_rank_pairs = values.zip((2..14).to_a)
      value_rank_pairs.each do |pairs|
        card = Card.new(suit, pairs[0], pairs[1])
        @cards_array << card
      end
    end
    # this verifies complete deck created accurately
    # puts cards_array.count
    # cards_array.each do |card|
    #   p card
    # end
    @cards_array.shuffle
  end

  def start
    puts "Welcome to War! (or Peace) This game will be played with #{@cards_array.count} cards. \n
    The players today are #{player1.name} and #{player2.name}. \n
    Type 'GO' to start the game!"
    @input = gets.chomp.downcase
    if @input == 'go'
      while @player1.deck.cards.count > 2 && @player2.deck.cards.count > 2
        take_turn
      end
    elsif
      p "unrecognized input '#{input}'/n  Please enter 'GO' to play"
      start
    end
    player_win?
    p "*~*~*~* #{@game_winner.name} has won the game! *~*~*~*"
  end

  def player_win?
    @player1.has_lost? | @game_winner=@player2
    @player2.has_lost? | @game_winner=@player1
  end

  def take_turn
    @turn_count += 1
    if @turn_count <= 1000000
      turn = Turn.new(player1, player2)
      # puts @player1.deck.cards[0].value
      # puts @player2.deck.cards[0].value
      # sleep 5
      # alt_turn if @turn_count >= 1000 || @turn_count <= 10000
      case turn.type
      when :basic
        p "#{@player1.name} played a #{@player1.deck.cards[0].value}"
        p "#{@player2.name} played a #{@player2.deck.cards[0].value}"
        p "Turn #{turn_count.to_s}: #{turn.winner.name} won 2 cards and now has #{turn.winner.deck.cards.count + 1} cards"
        # sleep 1.0

      when :war
        p "#{@player1.name} played a #{@player1.deck.cards[0].value}"
        p "#{@player2.name} played a #{@player2.deck.cards[0].value}"
        # sleep 1
        p "Turn #{turn_count.to_s}: WAR!"
        # sleep 1
        p "#{@player1.name} played a #{@player1.deck.cards[2].value}"
        p "#{@player2.name} played a #{@player2.deck.cards[2].value}"
        p "#{turn.winner.name} won 6 cards and now has #{turn.winner.deck.cards.count + 3} cards"
        # sleep 2

      when :mutually_assured_destruction
        p "#{@player1.name} played a #{@player1.deck.cards[0].value}"
        p "#{@player2.name} played a #{@player2.deck.cards[0].value}"
        # sleep 1
        p "Turn #{turn_count.to_s}: WAR!"
        # sleep 1
        p "#{@player1.name} played a #{@player1.deck.cards[2].value}"
        p "#{@player2.name} played a #{@player2.deck.cards[2].value}"
        p "Turn #{turn_count.to_s}: *!@!* Mutually Assured Destruction *!@!* 6 cards removed from play. #{@player1.deck.cards.count + @player2.deck.cards.count - 6} cards remain in play."
      end
      @winner = turn.winner
      turn.pile_cards
      turn.award_spoils(@winner)

    else
      p "Just as in real life, War has no winners."
      p "----------THE GAME IS A DRAW ------------"
      p "A strange game. The only winning move is not to play - Joshua"
      exit
    end
  end

end

Game.new.start



# def alt_turn
#   puts 'cls'
#   puts "      WARNING: YOUR CAR WARRANTY IS AB0UT TO EXPIRE
#     "
#   puts "Call us, we can help you renew your warranty before those major repairs start rolling in"
#   puts "advertisement"
#   @winner = turn.winner
#   turn.pile_cards
#   turn.award_spoils(@winner)
