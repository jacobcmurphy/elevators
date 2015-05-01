class Person
  attr_accessor :destination

  def initialize(destination)
    @destination = destination
  end

  def to_s
    "To #{@destination}"
  end
end
