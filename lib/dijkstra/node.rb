

class Node

  attr_accessor :name, :weight, :weight_from, :connections

  class << self
    def add_relations(node1, node2, distance)
      node1.add_relation node2, distance
      node2.add_relation node1, distance
    end
  end

  def infinity
    @infinity ||= Float::INFINITY
  end

  def initialize(name, weight=infinity, weight_from="", connections=[])
    @name = name
    @weight = weight
    @weight_from = weight_from
    @connections = connections
  end

  def relations
    @relations ||= {}
  end

  def add_relation(other_node, distance)
    relations[other_node.name] = distance
  end

  def set_weight(node, weight) # todo calculate distance
    return unless weight_less? weight
    self.weight = weight
    self.weight_from = node.name
  end

  def weight_less?(other_weight)
    other_weight < weight ? true : false
  end

  def calc_weight(node_name)
    relations[node_name] ? weight + relations[node_name] : infinity
  end



end
