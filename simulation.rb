class Simulation
  def initialize(building)
    @building = building
    @registered_items = [@building]
  end

  def register(obj)
    @registered_items << obj
  end

  # each step goes: people get on, elevators move 1 floor at most, people get off
  def run(n)
    puts "start"
    puts @building.to_s, ""
    n.times do |tick|
      puts "Tick #{tick+1}"
      @registered_items.each{ |item| item.tick }
      puts @building.to_s, ""
    end
  end
end
