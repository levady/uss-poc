require 'rails_helper'

RSpec.describe WaitTimeCalculator, type: :model do
  let!(:ride1) { create(:ride, duration: 3, capacity: 6) }
  let!(:ride2) { create(:ride, duration: 7, capacity: 30) }
  let!(:ride3) { create(:ride) }

  let!(:collection_time) { Time.parse("2020-10-08 10:00:0") }

  let!(:ride1_visitors_in1)  { create(:visitor, ride: ride1, visitors_count: 20, collected_at: collection_time) }
  let!(:ride1_visitors_in2)  { create(:visitor, ride: ride1, visitors_count: 12, collected_at: collection_time + 3.minutes) }
  let!(:ride1_visitors_out1) { create(:visitor, ride: ride1, visitors_count: -4, collected_at: collection_time + 1.minute) }

  let!(:ride2_visitors_in1)  { create(:visitor, ride: ride2, visitors_count: 50, collected_at: collection_time) }
  let!(:ride2_visitors_out1) { create(:visitor, ride: ride2, visitors_count: -11, collected_at: collection_time + 1.minute) }
  let!(:ride2_visitors_out2) { create(:visitor, ride: ride2, visitors_count: 40, collected_at: collection_time + 7.minute) }

  let!(:ride1_visitors_from_yesterday) { create(:visitor, ride: ride1, visitors_count: 50, collected_at: collection_time - 1.day) }
  let!(:ride2_visitors_from_yesterday) { create(:visitor, ride: ride2, visitors_count: -11, collected_at: collection_time + 1.day) }
  
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