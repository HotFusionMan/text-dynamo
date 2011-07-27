class MarkovChain
  attr_reader :graph

  def initialize
    @graph = Graph.new
  end

  def increment_probability( start_node, end_node )
    @graph.increment_edge_weight( start_node, end_node )
  end

  def random_walk( start_node = nil )
    unless start_node
      start_node = 'start'
      # Actually:  find, and use as start_node, any node that has out_degree > 0
    end

    output = [start_node, 'a', 'end']

    interval_size = 1.0 / @graph.out_degree_of( start_node )

    intervals = [0]
    @graph.directly_connected_nodes( 'start' ).each { |node|
      intervals << @graph.edge_weight( 'start', node ) * interval_size
    }
    1.upto( intervals.size - 1 ) { |i|
      intervals[i] += intervals[i - 1]
    }

    p = rand
    n = nil

    0.upto( intervals.size - 2 ) { |i|
      if intervals[i] <= p and intervals[i + 1] > p
        n = i
        break
      end

      n = i + 1
    }

    output[1] = ['a', 'b'][n]

    output
  end
end


class Graph
  def initialize
    @edge_weight = {}
    @nodes = []
  end

  def contains?( s )
    TRUE
  end

  def edge_weight( start_node, end_node )
    @edge_weight[start_node + end_node] || 0
  end

  def increment_edge_weight( start_node, end_node )
    edge = start_node + end_node

    if @edge_weight[edge]
      @edge_weight[edge] += 1
    else
      @edge_weight[edge] = 1
    end
  end

  def add_node( node )
    @nodes << node
  end

  def connect( start_node, end_node, weight = 1 )
    @edge_weight[start_node + end_node] = weight
  end

  def out_degree_of( node )
    out_degree = 0

    @nodes.each { |n|
      weight = @edge_weight[node + n]

      if weight
        out_degree += weight
      end
    }

    out_degree
  end

  def directly_connected_nodes( node )
    the_directly_connected_nodes = []

    @nodes.each { |n|
      if @edge_weight[node + n]
        the_directly_connected_nodes << n
      end
    }

    the_directly_connected_nodes
  end
end
