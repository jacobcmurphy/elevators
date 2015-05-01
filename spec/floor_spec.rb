require_relative './../floor'
require_relative './../person'
require_relative './../elevator'
require 'minitest/autorun'

describe "service" do

	before do
		@floor = Floor.new(2, get_people)
	end

  describe "test rider directions" do
    it "should not be empty" do
      @floor.empty?.must_equal false
    end
    it "should have both up and down movers" do
      @floor.riders_going_up.count.must_equal 2
      @floor.riders_going_down.count.must_equal 3
    end
  end

	describe "enter elevator" do
    it "sends upward riders on up elevator" do
      elev = Elevator.new(5)
      elev.stub :going_up, true do
        @floor.enter_elevator(elev)
        @floor.riders_going_up.must_be_empty
        @floor.riders_going_down.wont_be_empty
      end
    end
  end
end

def get_people
  people = []
  people << Person.new(1)
  people << Person.new(1)
  people << Person.new(0)
  people << Person.new(4)
  people << Person.new(4)
  people
end
