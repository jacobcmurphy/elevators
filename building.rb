require_relative 'controller'

class Building
  def initialize(**params)
    @elevators =  params.fetch :elevators
    @floors = params.fetch :floors
    @controller = ElevatorController.new @floors, @elevators
  end

  def direct_and_load_empty_elevators
    @controller.direct_free_elevators
  end

  def load_occupied_elevators
    @elevators.select{|elev| !elev.empty?}.each do |elev|
      @floors[elev.current_floor].enter_elevator elev
    end
  end

  def tick
    load_occupied_elevators
    direct_and_load_empty_elevators
  end

  def to_s
    # must find the elevators at each floor for printing purposes
    floors_to_elevs =  Hash[ @floors.map{|x| [x, []]} ]
    @elevators.each do |elev|
      floor = @floors[elev.current_floor]
      floors_to_elevs[floor] << elev
    end

    str = "***************\n"
    @floors.reverse.each do |floor|
      # print details about the floor
      str << "#{floor}"
      # print details about each elevator currently at that floor
      floors_to_elevs[floor].each do |elev|
        str << "#{elev}"
      end
      str << "\n"
    end
    str << "***************"
  end

end
