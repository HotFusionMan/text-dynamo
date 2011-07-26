class MarkovChain
  attr_reader :graph

  def initialize
    @graph = Graph.new
  end

  def increment_probability( start_node, end_node )
    @graph.add_node( start_node )
    @graph.add_node( end_node )
    @graph.connect( start_node, end_node, 1 )
  end

  def random_walk( start_node = nil )
    ['start', 'a', 'end']
  end
end


class Graph
  def initialize
    @edge_weight = Hash.new( 0 )
  end

  def contains?( s )
    TRUE
  end

  def edge_weight( start_node, end_node )
    @edge_weight[start_node + end_node]
  end

  def add_node( node )
  end

  def connect( start_node, end_node, weight = 1 )
    @edge_weight[start_node + end_node] += weight
  end

  def out_degree_of( node )
    0
  end
end
