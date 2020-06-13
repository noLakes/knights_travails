
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

class Board
  attr_accessor :rows
  attr_reader :knight

  def initialize(rows = 8)
    @rows = build_rows(rows)
    @knight = self.rand_pos
  end

  def build_rows(amt)
    output = []
    until output.length == amt do 
      output << Cell.build_cells(amt)
    end
    output
  end

  def txt
    output = []
    @rows.each_with_index do |row, idx|
      output.unshift("#{idx}#{row.map {|c| c.val}.join('')}\n")
    end
    output.unshift("\n")
    output. << "  0  1  2  3  4  5  6  7"
    output.join(' ')
  end

  def pos(y, x)
    begin
      self.rows[y].cells[x]
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

board = Board.new(8)
puts board.txt

#rework: remove Cell class and just make a row = [[0,0], [0,1], [0,2]....]
                                            #or  [0, 1, 2, 3, 4, 5, 6, 7,]

