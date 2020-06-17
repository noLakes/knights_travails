
class Node
  attr_reader :val, :adjacent_nodes

  def initialize(val)
    @val = val
    @adjacent_nodes = [] #values, not actual nodes
  end

  def add_edge(adjacent_node)
    if !@adjacent_nodes.include?(adjacent_node.val)
      @adjacent_nodes << adjacent_node.val
    end
    
  end

end

class Graph 
  attr_reader :nodes

  def initialize
    @nodes = {}
  end

  def add_node(node)
    #check if node already exists
    if !@nodes.include?(node.val)
      @nodes[node.val] = node
    end
  end

  def add_edge(node_val_1, node_val_2)
    @nodes[node_val_1].add_edge(@nodes[node_val_2])
    @nodes[node_val_2].add_edge(@nodes[node_val_1])
  end

  def add_edges(node_val_1, edges)
    edges.each do |e|
      add_edge(node_val_1, e)
    end
  end

  def get_node(node_val)
    @nodes[node_val]
  end

  def txt
    output = []
    @nodes.each_value do |node|
      output << "Node: #{node.val} Adj: #{node.adjacent_nodes}"
    end
    output.join("\n")
  end

  def shortest_path(start_val, end_val, queue = [], visited = [], path = [])
    return start_val if start_val == end_val
    
    queue << get_node(start_val)
    
    while !queue.empty? do
      read = queue.shift
      path << read.val
      break if read.val == end_val
      visited << read
      
      #add non seen adjacent nodes to queue
      get_adjacent_nodes(read).each do |node| 
        queue << node if !visited.include?(node) && !queue.include?(node)
      end

    end
    path
  end

  def get_adjacent_nodes(node, output = [])
    node.adjacent_nodes.each do |val|
      output << @nodes[val] 
    end
    output
  end
  
  #shortest_path(graph.nodes[[y, x]], graph.nodes[[y, x]])
end