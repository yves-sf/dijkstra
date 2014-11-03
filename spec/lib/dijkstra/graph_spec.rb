require_relative '../../spec_helper'
require 'dijkstra'


RSpec.describe Graph do

  subject {Graph}

  let(:valid_graph) {subject.new sample_data}
  let!(:graph) {subject.new}

  let(:edge01) {Edge.new "A,B,1"}
  let(:edge02) {Edge.new "A,C,2"}
  let(:edge03) {Edge.new "B,C,3"}

  let(:node_a) {Node.new "A"}
  let(:node_b) {Node.new "B"}
  let(:node_d) {Node.new "D"}

  describe "when first created" do
    it {expect(valid_graph.edges.size).to eq 10}
    it {expect(valid_graph.edges.first.class).to be Edge}
    it {expect(subject.new.nodes).to eq Hash.new}
  end

  describe "#node_add_update" do
    before do
      graph.nodes_add_update(edge01)
    end

    context "new node" do
      it {expect(graph.nodes.size).to eq 2}
      it {expect(graph.nodes["A"].name).to eq "A"}
      it {expect(graph.nodes["B"].name).to eq "B"}
      it {expect(graph.nodes["D"]).to be nil}
      it {expect(graph.nodes["A"].relations.keys).to include "B"}
      it {expect(graph.nodes["B"].relations.keys).to include "A"}
      it {expect(graph.nodes["A"].relations.keys).to_not include "C"}
    end

    context "a node exist" do
      before do
        graph.nodes_add_update(edge02)
      end

      it {expect(graph.nodes.size).to eq 3}
      it {expect(graph.nodes["C"].name).to eq "C"}
      it {expect(graph.nodes["A"].relations.keys).to include "C"}
    end
  end

  describe "#set_graph" do
    let!(:graph) {Graph.new sample_data}

    before do
      graph.set_graph
    end

    specify "create all the nodes" do
      expect(graph.nodes.size).to eq 7
    end

  end




  # describe "#not_visited" do
  #   context "initial state" do
  #
  #   end
  # end
  #
  #
  # describe "#add_edges" do
  #   context "new node" do
  #   end
  # end


  def sample_data
    %w(A,B,1 A,C,2 B,C,3 B,D,3 C,D,1 B,E,2 D,F,3 D,E,3 E,G,3 F,G,1)
  end

end