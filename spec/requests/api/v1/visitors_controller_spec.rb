# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::VisitorsController, type: :request do
  let(:current_time) { Time.now }
  let!(:ride) { create(:ride) }
  
  describe "POST create" do
    context "basic authenticated" do
      include_context :basic_auth_context

      it "return 200 OK on success" do
        payload = { visitor: { sensor_code: ride.sensor_code, visitors_count: 2, collected_at: current_time }}
        post api_v1_visitors_path(format: :json), params: payload, headers: headers
        expect(response.status).to eq(200)
      end
  
      it "return internal server error when ride does not exist" do
        payload = { visitor: { sensor_code: "foobar", visitors_count: 2, collected_at: current_time }}
        post api_v1_visitors_path(format: :json), params: payload, headers: headers
        expect(response.status).to eq(500)
      end
  
      it "return JSON error response for validation errors" do
        payload = { visitor: { sensor_code: nil, visitors_count: nil, collected_at: nil }}
        
        post api_v1_visitors_path(format: :json), params: payload, headers: headers
        
        expect(response.status).to eq(422)
        json = JSON.parse(response.body)
        expect(json).to eq({"errors"=>"Validation failed: Sensor code can't be blank, Visitors count can't be blank, Collected at can't be blank"})
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