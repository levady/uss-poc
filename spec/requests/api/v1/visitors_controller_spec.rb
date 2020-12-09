# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::VisitorsController, type: :request do
  let(:current_time) { Time.now }
  let!(:ride) { create(:ride) }
  
  describe "POST create" do
    context "basic authenticated" do
      include_context :basic_auth_context

      it "return 200 OK on success" do
        expect(VisitorWorker).to receive(:perform_async).with(ride.sensor_code, "2", current_time.strftime('%Y-%m-%d %H:%M:%S %z'))
        payload = { visitor: { sensor_code: ride.sensor_code, visitors_count: 2, collected_at: current_time }}
        post api_v1_visitors_path(format: :json), params: payload, headers: headers
        expect(response.status).to eq(200)
      end
    end

    context "unauthenticated" do
      it "return 401 unauthorized" do
        payload = { visitor: { sensor_code: ride.sensor_code, visitors_count: 2, collected_at: current_time }}
        post api_v1_visitors_path(format: :json), params: payload, headers: headers
        expect(response.status).to eq(401)
      end
    end
  end
end