require 'rails_helper'

RSpec.describe WaitTimeCalculator, type: :model do
  include_context :estimated_wait_time_fixtures
  
  describe "#estimate_all_rides" do
    it "retrieve and calculate the estimated wait time for all rides with the given collection time" do
      result = WaitTimeCalculator.new.estimate_all_rides(collection_time)
      expect(result).to match_array([
        {"id"=>ride1.id, "name"=>ride1.name, "status"=>"operational", "number_of_people"=>28, "estimated_wait_time"=>12.0}, 
        {"id"=>ride2.id, "name"=>ride2.name, "status"=>"operational", "number_of_people"=>79, "estimated_wait_time"=>14.0}, 
        {"id"=>ride3.id, "name"=>ride3.name, "status"=>"operational", "number_of_people"=>0, "estimated_wait_time"=>nil}])
    end

    it "retrieve and calculate the estimated wait time for all rides today" do
      result = WaitTimeCalculator.new.estimate_all_rides
      expect(result).to match_array([
        {"id"=>ride1.id, "name"=>ride1.name, "status"=>"operational", "number_of_people"=>0, "estimated_wait_time"=>nil}, 
        {"id"=>ride2.id, "name"=>ride2.name, "status"=>"operational", "number_of_people"=>0, "estimated_wait_time"=>nil}, 
        {"id"=>ride3.id, "name"=>ride3.name, "status"=>"operational", "number_of_people"=>0, "estimated_wait_time"=>nil}]
      )
    end
  end
end