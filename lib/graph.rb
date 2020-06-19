
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

  def build_distance_map(root_val = nil)
    map = {}
    @nodes.each_key { |key| map[key] = {'distance' => nil, 'previous' => nil} }
    if !root_val.nil?
      map[root_val]['distance'] = 0
    end
    map
  end

  def map_with_root(root_val, visited = [], queue = [])
    map = build_distance_map(root_val)
    queue << get_node(root_val)

    while !queue.empty? do
      read = queue.shift
      visited << read

      get_adjacent_nodes(read).each do |node|
        unless visited.include?(node) || queue.include?(node)
          queue << node
          map[node.val]['distance'] = map[read.val]['distance'] + 1
          map[node.val]['previous'] = read.val
        end
      end
    end
    map
  end
  
  def shortest_path(root_val, target_val, output = [])
    map = map_with_root(root_val)
    return 'nil' if map[target_val]['distance'].nil?
    output.unshift(target_val)
    read = map[target_val]
    until read['previous'] == nil
      output.unshift(read['previous'])
      read = map[read['previous']]
    end
    output
  end

  def get_adjacent_nodes(node, output = [])
    node.adjacent_nodes.each do |val|
      output << @nodes[val] 
    end
    output
  end
  
end