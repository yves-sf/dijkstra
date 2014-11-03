require_relative '../spec_helper'
require "dijkstra"



RSpec.describe "dijkstra" do

  class Dummy;include Dijkstra;end

  let(:dij) {Dummy.new}
  let(:node_a) {Node.new "A"}
  let(:node_b) {Node.new "B"}
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

  describe "swap_visited" do
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

    let(:graph) {dij.graph}

    describe "#graph" do
      it {expect(graph.edges.size).to eq 10}
      it {expect(graph.nodes.size).to eq 7}
    end

    specify "#set_start_node_weight" do
      expect(graph.nodes["B"].weight).to eq infinity

      dij.set_start_node_weight("B")

      expect(graph.nodes["B"].weight).to eq 0
    end

  end

  def sample_data
    %w(A,B,1 A,C,2 B,C,3 B,D,3 C,D,1 B,E,2 D,F,3 D,E,3 E,G,3 F,G,1)
  end

  def infinity
    @infinity ||= Float::INFINITY
  end
end

