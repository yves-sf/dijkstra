require_relative '../spec_helper'
require "dijkstra"

RSpec.describe "dijkstra" do

  class Dummy;include Dijkstra;end

  let(:dij) {Dummy.new}
  let(:node_a) {Node.new "A"}
  let(:node_b) {Node.new "B"}
  let(:node_c) {Node.new "C"}
  let(:node_d) {Node.new "D"}

  describe "#load_data" do
    before do
       dij.load_data
     end
    it { expect(dij.load_data).to eq sample_data }
  end

  describe "#visited" do
    it {expect(dij.visited.class).to eq Set}
  end

  describe "#visited_add" do
    it {expect(dij.visited_add(node_a)).to include node_a}
  end

  describe "#visited_del" do
    before { dij.visited_add(node_a) }
    it {expect(dij.visited).to include node_a}

    it {expect(dij.visited_del(node_a)).to_not include node_a}
  end

  describe "#not_visited" do
    it {expect(dij.not_visited.class).to eq Set}
  end

  describe "#not_visited_add" do
    it {expect(dij.not_visited_add(node_a)).to include node_a}
  end

  describe "#not_visited_del" do
    before { dij.not_visited_add(node_a) }
    it {expect(dij.not_visited).to include node_a}

    it {expect(dij.not_visited_del(node_a)).to_not include node_a}
  end

  describe "#set_not_visited" do
    let(:nodes) { {"A" => node_a, "B" => node_b}}

    before { dij.set_not_visited nodes }

    it {expect(dij.not_visited).to include node_a}
    it {expect(dij.not_visited).to include node_b}
  end

  describe "#swap_visited" do
    before do
      dij.not_visited_add(node_a)
      expect(dij.not_visited).to include node_a
      expect(dij.visited).to_not include node_a

      dij.swap_visited(node_a)
    end

    it {expect(dij.not_visited_del(node_a)).to_not include node_a}
    it {expect(dij.visited_add(node_a)).to include node_a}
  end

  context "processing graph" do

    let!(:graph) {dij.graph "./data/my_graph.txt"}

    describe "#graph" do
      it {expect(graph.edges.size).to eq 10}
      it {expect(graph.nodes.size).to eq 7}
    end

    specify "#set_start_node" do
      dij.not_visited << node_b
      expect(graph.nodes["B"].weight).to eq infinity
      expect(graph.nodes["B"].weight_from).to eq ""

      dij.set_start_node("B")

      expect(graph.nodes["B"].weight).to eq 0
      expect(graph.nodes["B"].weight_from).to eq "B"
      expect(dij.visited.first.name).to eq "B"
    end

    describe "#lowest_targets" do
      context "set the weight" do
        before {
          dij.set_start_node("A")
          dij.not_visited << graph.nodes["B"]
          dij.lowest_targets("A")
        }

        it {expect(graph.nodes["B"].weight).to eq 1}
        it {expect(graph.nodes["B"].weight_from).to eq "A"}
      end
    end

    describe "#navigate" do
      before do
        dij.set_not_visited graph.nodes
        dij.set_start_node("A")
        dij.navigate("A")
      end
      it {expect(graph.nodes["G"].weight).to eq 6}
      it {expect(graph.nodes["G"].weight_from).to eq "E"}
      it {expect(graph.nodes["E"].weight_from).to eq "B"}
      it {expect(graph.nodes["B"].weight_from).to eq "A"}
    end

    describe "#format_response" do
      before do
        dij.set_not_visited graph.nodes
        dij.set_start_node("A")
        dij.navigate("A")
      end

      it{expect(dij.format_response("my_graph.txt", "A", "G")).to eq "Dijkstra my_graph.txt A G Shortest path is [A,B,E,G] with total cost 6\n"}
    end

  end

  def sample_data
    %w(A,B,1 A,C,2 B,C,3 B,D,3 C,D,1 B,E,2 D,F,3 D,E,3 E,G,3 F,G,1)
  end

  def infinity
    @infinity ||= Float::INFINITY
  end
end

