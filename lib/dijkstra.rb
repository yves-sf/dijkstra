require 'dijkstra/version'
require 'dijkstra/graph'
require 'dijkstra/edge'
require 'dijkstra/node'

require "set"


module Dijkstra

  def process(start=nil, stop=nil)
    return unless start && stop
    set_start_node_weight(start)


  end

  def load_data(file="./data/my_graph.txt")
    io = File.open(file, "r")
    edges = io.map { |l| l.chomp}
    io.close
    edges
  end

  def graph(file="./data/my_graph.txt")
    @graph ||= Graph.new load_data(file)
  end

  def set_start_node_weight(start)
    graph.nodes[start].weight = 0
  end

  def set_weight(node, distance)

  end

  def visited
    @visited ||= Set.new
  end

  def visited_add(element)
    visited << element if element
  end

  def visited_del(element)
    visited.delete element
  end

  def not_visited
    @not_visited ||= Set.new
  end

  def not_visited_add(element)
    not_visited << element if element
  end

  def not_visited_del(element)
    not_visited.delete element
  end

  def swap_visited(element)
    visited_add(element)
    not_visited_del(element)
  end



 end
