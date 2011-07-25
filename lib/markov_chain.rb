class MarkovChain
  attr_reader :graph

  def initialize
    @graph = Graph.new
  end

  def increment_probability( start_node, end_node )
  end
end


class Graph
  def contains?( s )
    TRUE
  end

  def edge_weight( start_node, end_node )
    1
  end
end
