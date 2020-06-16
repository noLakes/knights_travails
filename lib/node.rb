
class Node
  attr_reader :val, :adjacent_nodes

  def initialize(val)
    @val = val
    @adjacent_nodes = []
  end

  def add_edge(adjacent_node)
    #make sure adjacent doesnt already contain the node
    @adjacent_nodes << adjacent_node
  end

end

class Graph 

  def initialize
    @nodes = {}
  end

  def add_node(node)
    #check if node already exists
    @nodes[node.val] = node
  end

  def add_edge(node1, node2)
    @nodes[node1].add_edge(@nodes[node2])
    @nodes[node2].add_edge(@nodes[node1])
  end

  def add_node_with_edges(node, edges)

  end

end