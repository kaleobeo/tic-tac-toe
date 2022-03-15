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
    @board.each_value { |row| puts "#{row[0]} | #{row[1]} | #{row[2]}" }
  end

end

class Player

end

