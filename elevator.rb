class Elevator
  attr_accessor :going_up, :current_floor
  BOTTOM_FLOOR = 0
  ELEV_MAX_PERSONS = 5
  ELEV_RESTING_FLOOR = 0

  def initialize(number_of_floors)
    @going_up = true
    @current_floor = ELEV_RESTING_FLOOR
    @number_of_floors = number_of_floors
    @top_floor = BOTTOM_FLOOR+number_of_floors-1
    @stops = Hash[ (BOTTOM_FLOOR..@top_floor).to_a.map{|x| [ x, [] ]} ]
  end

  def move
    if @current_floor == @top_floor
      @going_up = false
    elsif @current_floor == BOTTOM_FLOOR
      @going_up = true
    end
    directed_move

    unload
  end

  def go_to_resting_floor
    if !@going_up && ELEV_RESTING_FLOOR > @current_floor
      @going_up = true
    elsif @going_up && ELEV_RESTING_FLOOR < @current_floor
        @going_up = false
    end

    # counteract the move command for changing floors if already here
    @current_floor += directed_move*-1 if @current_floor == ELEV_RESTING_FLOOR
  end

  def full?
    counter = @stops.values.inject(0){|sum, riders| sum += riders.count}
    counter >= ELEV_MAX_PERSONS
  end

  def empty?
    @stops.each do |floor, disembarkers|
      return false unless disembarkers.empty?
    end
    true
  end

  def ride(rider)
    return false if full?

    @stops[rider.destination] << rider
    true
  end

  def tick
    self.move
  end

  def to_s
    direction = @going_up ? "u" : "d"
    rider_info = @stops.select{|k,v| v.count > 0}.map{|k,v| "#{v.count} riders to #{k}"}
    "|#{direction}, #{rider_info}|  "
  end

  private

  def directed_move
    @current_floor += @going_up ? 1 : -1
  end

  def unload
    @stops[@current_floor] = []
  end
end
