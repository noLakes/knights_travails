
class Cell
  attr_accessor :val
  def initialize(val = '[ ]')
    @val = val
  end

  def knight?
    @val == '[K]'
  end

  def self.build_cells(amt)
    output = []
    amt.times {output << Cell.new}
    output
  end
end

class Row
  attr_accessor :cells
  attr_reader :num

  def initialize(num)
    @num = num
    @cells = Cell.build_cells(8)
  end

  def txt
    "#{@num}#{@cells.map {|c| c.val}.join('')}"
  end
end

class Board
  attr_accessor :rows

  def initialize
    @rows = Array.new
    until @rows.length == 8 do 
      @rows << Row.new(@rows.length)
    end
  end

  def txt
    output = []
    @rows.each do |row|
      output.unshift("#{row.txt}\n")
    end
    output.unshift("\n")
    output. << "  0  1  2  3  4  5  6  7"
    output.join(' ')
  end

  def pos(y, x)
    self.rows[y].cells[x]
  end

end

class Knight
  def initialize
    
  end

end

board = Board.new
board.rows[3].cells[3].val = '[K]'
puts board.txt
p board.pos(3,3)
