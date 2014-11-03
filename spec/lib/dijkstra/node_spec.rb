require_relative '../../spec_helper'
require 'dijkstra'


RSpec.describe Node do

  subject {Node}
  let!(:node_a) {subject.new("A")}
  let!(:node_b) {subject.new("B")}
  let!(:node_c) {subject.new("C")}
  let!(:node_d) {subject.new("C")}

  describe "when first created" do
    let(:valid_node) { subject.new "A" }

    it {expect(valid_node.name).to eq "A"}
    it {expect(valid_node.infinity).to eq infinity}
    it {expect(valid_node.weight).to eq infinity}
    it {expect(valid_node.weight_from).to eq ""}
    it {expect(valid_node.connections).to eq []}
  end

  describe "#set_weight" do
    before do
      expect(node_b.weight).to eq infinity
      expect(node_b.weight_from).to eq ""
      node_b.set_weight node_a, 10
    end

    it {expect(node_b.weight).to eq 10}
    it {expect(node_b.weight_from).to eq "A"}
  end

  describe "#weight_less?" do
    context "weight is infinite" do
      it {expect(node_b.weight_less?(10)).to be true}
    end
    context "weight was already set" do
      before {node_b.set_weight node_a, 10}
      it {expect(node_b.weight_less?(8)).to be true}
      it {expect(node_b.weight_less?(15)).to be false}
    end
  end

  describe "#calc_weight" do
    before do
      node_a.weight = 0
      Node.add_relations node_a, node_b, 3
    end
    it {expect(node_a.calc_weight "B").to eq 3}
  end


  describe "relations" do
    context "for a node" do
      it {expect(node_a.relations).to eq Hash.new}

      specify "#add_relation toward other node" do
        node_a.add_relation(node_b, 10)
        expect(node_a.relations[node_b.name]).to eq 10
      end
    end

    describe "::add_relations" do
      context "add a bidirectional relations between 2 nodes" do
        before do
          subject.add_relations(node_a, node_b, 5)
        end

        specify {expect(node_a.relations.keys).to include "B"}
        specify {expect(node_a.relations[node_b.name]).to eq 5}
        specify {expect(node_b.relations.keys).to include "A"}
        specify {expect(node_b.relations[node_a.name]).to eq 5}
      end
    end
  end

  def infinity
    @infinity ||= Float::INFINITY
  end


end