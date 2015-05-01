require_relative 'building'
require_relative 'floor'
require_relative 'elevator'
require_relative 'person'
require_relative 'simulation'

NUM_OF_FLOORS = 4
MAX_PEOPLE_PER_FLOOR = 5
NUM_OF_ELEVATORS = 2
NUM_OF_TICKS = 5

def make_floors
  floors = []
  (0...NUM_OF_FLOORS).each do |floor_num|
    floors << Floor.new(floor_num, get_people(floor_num) )
  end
  floors
end

def make_elevators
  elev_arr = []
  NUM_OF_ELEVATORS.times do
    elev_arr << Elevator.new(NUM_OF_FLOORS)
  end
  elev_arr
end

# make between 0 and 5 people waiting
def get_people(floor_num)
  number_of_people = rand(0..MAX_PEOPLE_PER_FLOOR)
  people_arr = []
  number_of_people.times do
    destination_floor = rand(0...NUM_OF_FLOORS)
    # makes sure that no one wants to go to the floor they start on
    people_arr << Person.new(destination_floor) if destination_floor != floor_num
  end
  people_arr
end

floors = make_floors
elevators = make_elevators
building = Building.new(elevators: elevators, floors: floors)

sim = Simulation.new building

sim.register building
elevators.each do |elev|
  sim.register elev
end

sim.run NUM_OF_TICKS
