# frozen_string_literal: true

class GameBoard
  def initialize
    @board = {
      a: [' ', ' ', ' '],
      b: [' ', ' ', ' '],
      c: [' ', ' ', ' ']
    }
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
end
