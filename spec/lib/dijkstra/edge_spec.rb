require_relative '../../spec_helper'
require 'dijkstra'


RSpec.describe Edge do

  subject {Edge}

  describe "when first created" do
    let(:valid_edge) { subject.new "a,b,5" }

    it {expect(valid_edge).to respond_to :start}
    it {expect(valid_edge).to respond_to :stop}
    it {expect(valid_edge).to respond_to :length}
    it {expect(valid_edge.length.class).to be Fixnum}

  end

end