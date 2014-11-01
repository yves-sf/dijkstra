
class Edge
  attr_accessor :start, :stop, :length

  def initialize(triplet)
    @start, @stop, length = triplet.split(',')
    @length = length.to_i
  end
end

