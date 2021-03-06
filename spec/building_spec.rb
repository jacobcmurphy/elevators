require 'minitest/autorun'
require_relative './../building'

describe "service" do
	it "will respond" do
		b = Building.new(elevators: [], floors: [])
		b.must_respond_to :direct_and_load_empty_elevators
		b.must_respond_to :load_occupied_elevators
		b.must_respond_to :to_s
		b.must_respond_to :tick
	end

	describe "on tick" do
		it "will call the elevator" do
			elev = MiniTest::Mock.new
			floor = MiniTest::Mock.new

			elev.expect(:empty?, false)
			elev.expect(:current_floor, 0)
			floor.expect(:enter_elevator, true, [elev])

			b = Building.new(elevators: [elev], floors: [floor])
			b.stub :direct_and_load_empty_elevators, true do
				b.tick
			end

			elev.verify
			floor.verify
		end
  end
end
