

class Node

  attr_accessor :name, :weight, :visited, :connections

  class << self
    def add_relations(node1, node2, distance)
      node1.add_relation node2, distance
      node2.add_relation node1, distance
    end
  end

  def infinity
    @infinity ||= Float::INFINITY
  end

  def initialize(name, weight=infinity, visited=false, connections=[])
    @name = name
    @weight = weight
    @visited = visited
    @connections = connections
  end

  def relations
    @relations ||= {}
  end

  def add_relation(other_node, distance)
    relations[other_node.name] = distance
  end

end
