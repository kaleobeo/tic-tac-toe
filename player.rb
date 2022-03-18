# frozen_string_literal: true

# Define class Player that manages player moves and points
class Player
  @@legal_symbols = %w[x o]
  attr_reader :symbol, :parent_game

  def initialize(parent_game)
    @parent_game = parent_game
    puts('Please enter "x" or "o" for this player.')
    @symbol = gets.chomp
    until @@legal_symbols.include?(@symbol)
      puts 'Please enter a valid symbol.'
      @symbol = gets.chomp
    end
    @@legal_symbols.delete(@symbol)
  end

  def make_move
    puts "#{@symbol} player: Which row would you like to play in?"
    row = gets.chomp
    puts "#{@symbol} player: Which column would you like to play in?"
    num = gets.chomp.to_i

    if row.between?('a', 'c') && num.between?(1, 3) && parent_game.valid_space?(row, num)
      parent_game.place_symbol(symbol, row, num)
    else
      puts 'Looks like you inputted something wrong, try again.'
      make_move
    end
  end

  def self.reset
    @@legal_symbols = %w[x o]
  end
end
