class ElevatorController
  def initialize(floors, elevators)
    @floors = floors
    @elevators = elevators
  end

  # direct the empty elevators to tell them to start going up or down
  # all occupied elevators keep moving in the direction they are going
  def direct_free_elevators
    free_elevators = @elevators.select{|elev| elev.empty?}
    free_elevators.each do |elev|
      best_direction = find_direction_for_elevator elev

      case best_direction
      when :up
        elev.going_up = true
      when :down
        elev.going_up = false
      else
        elev.go_to_resting_floor
      end
      @floors[elev.current_floor].enter_elevator elev
    end
  end

  private
  def find_direction_for_elevator(elev)
    if !@floors[elev.current_floor].riders_going_down.empty?
      return :down
    elsif !@floors[elev.current_floor].riders_going_up.empty?
      return :up
    else
      closest_floor_num = find_closest_floor_to elev
      if closest_floor_num
        return (closest_floor_num > elev.current_floor) ? :up : :down
      else
        return :go_to_resting_floor
      end
    end
  end

  def find_closest_floor_to(elev)
    current_floor = elev.current_floor
    # find the closest floor with people waiting
    (0..@floors.count).each do |n|
      if current_floor+n < @floors.count && !@floors[current_floor + n].empty?
        return current_floor + n
      elsif current_floor-n >= 0 && !@floors[current_floor - n].empty?
        return current_floor - n
      end
    end

    # all floors are empty - start going to resting
    return nil
  end

end
