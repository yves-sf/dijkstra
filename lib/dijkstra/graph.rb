require "set"

class Graph

  attr_accessor :edges, :nodes

  def initialize(edges_data=[])
    @edges = edges_data.map { |ed| Edge.new ed }
  end

  def nodes
    @nodes ||={}
  end

  def nodes_add_update(edge)
    nodes[edge.start] ||= Node.new edge.start
    nodes[edge.stop]  ||= Node.new edge.stop
    Node.add_relations nodes[edge.start], nodes[edge.stop], edge.length
  end

  def set_graph
    self.edges.each { |edge| nodes_add_update(edge) }
  end

  # def not_visited
  #   @not_visited ||= Set.new
  # end
  #
  # def not_visited_add(element=nil)
  #   @not_visited << element if element
  # end
  #
  # def not_visited_del(element=nil)
  #   @not_visited
  # end
  #
  # def visited
  #   @visited ||= Set.new
  # end
  #
  # def visited_add(element=nil)
  #   visited << element if element
  #   @visited
  # end
  #
  # def visited_del(element=nil)
  #   visited
  # end


end
