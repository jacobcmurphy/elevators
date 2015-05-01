class Floor
  attr_accessor :rider_queue
  attr_reader :floor_level

  def initialize(floor_level, queue = [])
    @floor_level = floor_level
    @rider_queue = queue
  end

  def enter_elevator(elev)
    if elev.going_up
      riders_going_up.each do |rider|
        @rider_queue.delete rider if elev.ride rider
      end
    else
      riders_going_down.each do |rider|
        @rider_queue.delete rider if elev.ride rider
      end
    end
  end

  def empty?
    @rider_queue.empty?
  end

  def riders_going_up
    @rider_queue.select{ |x| x.destination > floor_level }
  end

  def riders_going_down
    @rider_queue.select{ |x| x.destination < floor_level }
  end

  def to_s
    "* F #{@floor_level}: #{riders_going_up.count} u, #{riders_going_down.count} d * "
  end
end
