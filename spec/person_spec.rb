require_relative './../person'
require 'minitest/autorun'

describe "service" do
	before do
		@person = Person.new(5)
	end

	describe "test creation" do
    it "should be a Person" do
      @person.must_be_instance_of Person
    end
  end

  describe "test attributes and methods" do
    it "should has a destination" do
      @person.destination.must_equal 5
    end
    it "can form a string" do
      @person.to_s.must_equal "To 5"
    end
  end
end
