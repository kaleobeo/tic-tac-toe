# frozen_string_literal: true

# Mangaes gameboard values
class GameBoard
  DEFAULT_BOARD = {
    a: [' ', ' ', ' '],
    b: [' ', ' ', ' '],
    c: [' ', ' ', ' ']
  }.freeze
  def initialize
    
  end

  def to_s
    spacer = '-+-+-'
    @board.each_pair do |row, values|
      if row == :c
        puts "#{values[0]}|#{values[1]}|#{values[2]}"
      else
        puts "#{values[0]}|#{values[1]}|#{values[2]}", spacer
      end
    end
  end
end

class Player
  @@legal_symbols = %w[x o]
  attr_reader :symbol

  def initialize
    puts 'Please enter "x" or "o" for this player.'
    @symbol = gets.chomp
    until @@legal_symbols.include?(@symbol)
      puts 'Please enter a valid symbol.'
      @symbol = gets.chomp
    end
    @@legal_symbols.delete(@symbol)
  end

  def self.legal_symbols
    @@legal_symbols
  end
end
