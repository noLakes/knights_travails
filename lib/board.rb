
class Knight
  attr_accessor :board

  def initialize
    @board = build_board
  end

  def build_board
    board = Array.new
    until board.length == 8 do
      row = Array.new
      until row.length == 8 do
        row << [board.length, row.length]
      end
      board << row
    end
    board
  end

  def txt
    output = ["\n"]
    @board.each_with_index do |row, idx|
      output << " #{idx}#{ row.map { |pos| '[ ]' }.join('') }\n"
    end
    output << "   0  1  2  3  4  5  6  7\n"
    output.join('')
  end

  def pos(y, x)
    begin
      @board[y][x]
    rescue
      'nil'
    end
  end

  def rand_pos
    y = rand(0..7)
    x = rand(0..7)
    pos(y, x)
  end

end

knight = Knight.new
p knight.pos(99,6)
puts knight.txt
