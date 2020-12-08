require 'rails_helper'

RSpec.describe VisitorDataCollector, type: :model do
  let(:ride) { create(:ride) }

  describe "#run!" do
    context "validations" do
      it "raise an error when sensor_code is nil" do
        expect { 
          VisitorDataCollector.new(nil, 10, Time.now).run!
        }.to raise_error(ActiveModel::ValidationError, "Validation failed: Sensor code can't be blank")
      end

      it "raise an error when visitors_count is nil" do
        expect { 
          VisitorDataCollector.new("da-code", nil, Time.now).run!
        }.to raise_error(ActiveModel::ValidationError, "Validation failed: Visitors count can't be blank")
      end

      it "raise an error when collected_at is nil" do
        expect { 
          VisitorDataCollector.new("da-code", 10, nil).run!
        }.to raise_error(ActiveModel::ValidationError, "Validation failed: Collected at can't be blank")
      end

      it "raise a not found exception when a ride does not exist" do
        expect { 
          VisitorDataCollector.new("ride-not-found", 10, Time.now).run!
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    it "persist visitor record to DB when a ride exist" do
      # given
      collected_at = Time.now
      
      # when
      service = VisitorDataCollector.new(ride.sensor_code, 10, collected_at)
      expect { service.run! }.not_to raise_error

      # then
      expect(Visitor.count).to eq(1)
      visitor = Visitor.first
      expect(visitor.visitors_count).to eq(10)
      expect(visitor.collected_at.utc.to_s).to eq(collected_at.utc.to_s)
    end

    it "does not insert duplicate data points" do
      # given
      collected_at = Time.now
      VisitorDataCollector.new(ride.sensor_code, 10, collected_at).run!
      
      # when
      expect {
        VisitorDataCollector.new(ride.sensor_code, 10, collected_at).run!
      }.not_to raise_error

      # then
      expect(Visitor.count).to eq(1)
    end
  end
end
