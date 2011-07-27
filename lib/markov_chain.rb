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

    output = [start_node]

    current_node = start_node

    loop do
      out_degree = @graph.out_degree_of( current_node )
      break if out_degree == 0

      interval_size = 1.0 / out_degree

      intervals = [0]
      directly_connected_nodes = @graph.directly_connected_nodes( current_node )

      directly_connected_nodes.each { |node|
        intervals << @graph.edge_weight( current_node, node ) * interval_size
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

      current_node = directly_connected_nodes[n]
      output << current_node
    end

    output
  end
end


class Graph
  def initialize
    @edge_weight = {}
    @nodes = []
  end

  def contains?( node )
    @nodes.include?( node )
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
