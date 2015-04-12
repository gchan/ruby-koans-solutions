# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

require_relative 'about_dice_project'
require_relative 'about_scoring_project'

class Player
  attr_accessor :score, :number

  def initialize(number)
    @score = 0
    @number = number
    @in_game = false
  end

  def add_score(score)
    @score += score if in_game?(score)
  end

  private

  def in_game?(score)
    @in_game ||= score >= 300
  end
end

class Game
  attr_reader :players, :round, :game_over

  def initialize(no_players)
    @dice = DiceSet.new
    @round = 0
    @game_over = false
    @players = []
    no_players.times { |i| @players << Player.new(i + 1) }
  end

  def new_round
    return if game_over

    @round += 1
    puts "Round #{round}"

    players.each_with_index do |player, idx|
      score = score(@dice.roll(5))
      player.add_score(score)

      puts "Player #{player.number} - Score #{score} - Total #{player.score}"

      @game_over ||= player.score >= 3000
    end

    puts ""
  end

  def print_winner
    return nil unless game_over

    winner = players.max_by(&:score)
    puts "Winner: Player #{winner.number}"
  end
end


game = Game.new(3)

while !game.game_over
  game.new_round
end

game.print_winner