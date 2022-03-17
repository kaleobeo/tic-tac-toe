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
    @game_over = false
    @first_player = Player.new(self)
    @second_player = Player.new(self)
    play_game
  end

  def play_game
    until @game_over
      one_turn(@first_player)
      break if @game_over
      if board_full?
        puts 'Cat\'s game!'
        break
      end

      one_turn(@second_player)
    end
  end

  def valid_space?(row, col)
    @board[row.to_s][col - 1] == ' '
  end

  def place_symbol(symbol, row, num)
    @board[row][num - 1] = symbol
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

  private

  def board_full?
    [@board['a'], @board['b'], @board['c']].all? do |row|
      row.none? { |space| space == ' ' }
    end
  end

  def one_turn(player)
    puts self
    player.make_move
    check_for_wins(player.symbol)
  end

  def check_for_wins(symbol)
    [row_wins, column_wins, diagonal_wins].each do |type|
      type.each do |condition|
        next unless condition.all? { |space| space == symbol }

        puts self
        puts "#{symbol} wins!"
        @game_over = true
      end
    end
  end

  def row_wins
    [
      @board['a'],
      @board['b'],
      @board['c']
    ]
  end

  def column_wins
    [@board['a'], @board['b'], @board['c']].transpose
  end

  def diagonal_wins
    [
      [@board['a'][0], @board['b'][1], @board['c'][2]],
      [@board['a'][2], @board['b'][1], @board['c'][0]]
    ]
  end

  def reset
    Player.reset
    @board = DEFAULT_BOARD.dup
  end
end

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

game = GameBoard.new
