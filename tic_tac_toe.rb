# frozen_string_literal: true

# Mangaes gameboard values
class GameBoard
  attr_reader :first_player, :second_player

  DEFAULT_BOARD = {
    'a' => [' ', ' ', ' '],
    'b' => [' ', ' ', ' '],
    'c' => [' ', ' ', ' ']
  }.freeze

  def initialize
    @board = DEFAULT_BOARD.dup
    @first_player = Player.new(self)
    @second_player = Player.new(self)
  end

  def to_s
    spacer = '  -+-+-'
    @board.each_pair do |row, values|
      print "#{row} "
      if row == :c
        puts "#{values[0]}|#{values[1]}|#{values[2]}"
      else
        puts "#{values[0]}|#{values[1]}|#{values[2]}", spacer
      end
    end
    puts '  1 2 3'
  end

  def place_symbol(symbol, row, num)
    @board[row][num - 1] = symbol if @board[row][num - 1] == ' '
  end

  private

  def reset
    Player.reset
    @board = DEFAULT_BOARD.dup
  end
end

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
    puts 'Which row would you like to play in?'
    row = gets.chomp
    puts 'Which column would you like to play in?'
    num = gets.chomp.to_i

    if row.between?('a', 'c') && num.between?(1, 3)
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
