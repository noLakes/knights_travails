require 'pry'

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

  def build_distance_map(root_val = nil)
    #builds a hash map for each node
    map = {}
    @nodes.each_key { |key| map[key] = {'distance' => nil, 'previous' => nil} }
    if !root_val.nil?
      map[root_val]['distance'] = 0
    end
    map
  end

  def distance_from_root(root_val, visited = [], queue = [])
    #builds distance map and then sets a source node
    map = build_distance_map(root_val)
    queue << get_node(root_val)

    while !queue.empty? do
      read = queue.shift
      visited << read
      #en-queue unvisited && non queued adjacents to read
      #set their map[key] distance to = read[dist] + 1 and previous to = read.val
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
  
  def shortest_path(root_val, target_val)
    
  end

  def get_adjacent_nodes(node, output = [])
    node.adjacent_nodes.each do |val|
      output << @nodes[val] 
    end
    output
  end
  
end