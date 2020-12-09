require 'rails_helper'
RSpec.describe VisitorWorker, type: :worker do
  describe "#perform" do
    it "collect visitor data" do
      expect_any_instance_of(VisitorDataCollector).to receive(:run!)
      VisitorWorker.new.perform("ride-1", 10, Time.now)
    end
  end
end
