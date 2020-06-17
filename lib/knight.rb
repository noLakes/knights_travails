require_relative 'graph.rb'

class Knight
  attr_accessor :board, :pos, :graph
  attr_reader :MOVES, :valid

  def initialize
    @MOVES = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]]
    @board = build_board
    @pos =  rand_pos
    @valid = valid_moves(pos)
    @graph = build_graph
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
      output << " #{idx}#{ row.map { |pos| check_cell(pos) }.join('') }\n"
    end
    output << "   0  1  2  3  4  5  6  7\n"
    output.join('')
  end

  def check_cell(cell)
    if @pos == cell
      '[K]'
    elsif @valid.include?(cell)
      '[O]'
    else
      '[ ]'
    end
  end

  def set_pos(pos)
    @pos = pos
    @valid = valid_moves(@pos)
  end

  def get_pos(y, x)
    if y.between?(0, 7) and x.between?(0, 7)
      return @board[y][x]
    else
      return 'nil'
    end
  end

  def rand_pos
    get_pos(rand(0..7), rand(0..7))
  end

  def valid_moves(pos = @pos)
    output = []
    @MOVES.each do |move| 
      new_pos = get_pos(pos[0] + move[0], pos[1] + move[1])
      output << new_pos unless new_pos == 'nil'
    end
    output
  end

  def build_graph
    graph = Graph.new
    all_pos = @board.flatten(1)
    all_pos.each { |p| graph.add_node(Node.new(p)) }
    all_pos.each { |p| graph.add_edges(p, valid_moves(p)) }
    graph
  end

end


knight = Knight.new
puts knight.txt
p knight.pos
p knight.valid
puts knight.graph.txt
