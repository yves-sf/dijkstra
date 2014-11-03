require "set"

class Graph

  attr_accessor :edges, :nodes

  def initialize(edges_data=[])
    @edges = edges_data.map { |ed| Edge.new ed }
    set_graph
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


end
