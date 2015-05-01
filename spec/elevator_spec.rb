require_relative './../elevator'
require_relative './../person'
require 'minitest/autorun'

describe "service" do

	before do
		@elev = Elevator.new 5
	end

	describe "test move" do
    before do
      @elev.current_floor = 3
    end

    it "should go down" do
      @elev.going_up = false
      @elev.move
      @elev.current_floor.must_equal 2
    end

    it "should go up" do
      @elev.going_up = true
      @elev.move
      @elev.current_floor.must_equal 4
    end

    it "should catch top and bottom" do
      @elev.current_floor = 4
      @elev.move
      @elev.going_up.must_equal false
      @elev.current_floor.must_equal 3

      @elev.current_floor = 0
      @elev.move
      @elev.going_up.must_equal true
      @elev.current_floor.must_equal 1
    end
  end

  describe "test going to resting floor" do
    before do
      @elev.going_up = true
    end
    it "should go down" do
      @elev.current_floor = 4
      @elev.go_to_resting_floor
      @elev.move
      @elev.current_floor.must_equal 3
      @elev.going_up.must_equal false
    end


    it "should stay still" do
      @elev.current_floor = 0
      @elev.go_to_resting_floor
      @elev.move
      @elev.current_floor.must_equal 0
    end
  end

  describe "test riding" do
    before do
      @person = Person.new 4
    end

    it "should be full" do
      5.times{@elev.ride @person}
      @elev.full?.must_equal true
			@elev.ride(@person).must_equal false
    end

    it "should not be full" do
      3.times{@elev.ride @person}
      @elev.full?.must_equal false
    end

    it "should be empty" do
      @elev.empty?.must_equal true
    end

    it "should not be empty" do
      @elev.ride @person
      @elev.empty?.must_equal false
    end
  end
end
