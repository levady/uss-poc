require "rails_helper"

shared_context :estimated_wait_time_fixtures do
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
end
