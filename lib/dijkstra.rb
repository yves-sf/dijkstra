require_relative './dijkstra/version'
require_relative './dijkstra/graph'
require_relative './dijkstra/edge'
require_relative './dijkstra/node'
require "set"
require "byebug"

module Dijkstra

  def process(file="./data/my_graph.txt", start=nil, stop=nil)
    return unless start && stop
    graph file
    set_not_visited graph.nodes
    set_start_node start
    navigate start
    $stdout << (format_response file, start, stop)
  end

  def load_data(file="./data/my_graph.txt")
    io = File.open(file, "r")
    edges = io.map { |l| l.chomp}
    io.close
    edges
  end

  def graph(file=nil)
    @graph ||= Graph.new load_data(file)
  end

  def set_not_visited(nodes)
    nodes.each {|_k, node| not_visited << node}
  end

  def set_start_node(start)
    node = graph.nodes[start]
    node.weight = 0
    node.weight_from = node.name
    swap_visited node
  end

  def lowest_targets(node_name)
    node = graph.nodes[node_name]
    lowest = node.infinity
    lowest_node = node
    not_visited.each do |nv|
      nv.set_weight(node, node.calc_weight(nv.name))
      if nv.weight < lowest
        lowest = nv.weight
        lowest_node = nv
      end
    end
    lowest_node
  end

  def navigate(node_name)
    new_visited = lowest_targets(node_name)
    swap_visited new_visited
    navigate(new_visited.name) unless not_visited.empty?
    new_visited
  end

  def format_response(file="", start="A", stop="G")
    build_path stop, start
    "Dijkstra #{file} #{start} #{stop} Shortest path is [#{path[0..-2]}] with total cost #{total_cost(stop)}\n"
  end

  def build_path(node_name, start)
    path node_name
    return if node_name == start
    build_path graph.nodes[node_name].weight_from, start unless node_name == start
  end

  def path(node_name=nil)
    @path ||= ""
    @path.insert(0, "#{node_name},") if node_name
    @path
  end

  def total_cost(stop)
    graph.nodes[stop].weight
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

class Dij
  include Dijkstra
end


if __FILE__ == $0
  Dij.new.process ARGV[0], ARGV[1], ARGV[2]
end