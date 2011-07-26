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
    output = ['start', 'a', 'end']

    interval_size = 1.0 / @graph.out_degree_of( 'start' )

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
    @edge_weight = Hash.new( 0 )
  end

  def contains?( s )
    TRUE
  end

  def edge_weight( start_node, end_node )
    @edge_weight[start_node + end_node] || 0
  end

  def add_node( node )
  end

  def connect( start_node, end_node, weight = 1 )
    @edge_weight[start_node + end_node] += weight
  end

  def out_degree_of( node )
    case node
      when 'start'
        1
      when 'end'
        0
    end
  end

  def directly_connected_nodes( node )
    case node
      when 'start'
        ['a', 'b']
    end
  end
end
