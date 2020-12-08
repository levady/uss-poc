# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::RidesController, type: :request do
  include_context :estimated_wait_time_fixtures

  describe "GET index" do
    context "basic authenticated" do
      include_context :basic_auth_context

      it "return rides with estimated wait time JSON response" do
        # given
        allow(Time).to receive(:now).and_return(collection_time)
        
        # when
        get api_v1_rides_path(format: :json), headers: headers
        
        # then
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json).to match_array([
          {"id"=>ride1.id, "name"=>ride1.name, "status"=>"operational", "number_of_people"=>28, "estimated_wait_time"=>12.0}, 
          {"id"=>ride2.id, "name"=>ride2.name, "status"=>"operational", "number_of_people"=>79, "estimated_wait_time"=>14.0}, 
          {"id"=>ride3.id, "name"=>ride3.name, "status"=>"operational", "number_of_people"=>0, "estimated_wait_time"=>nil}]
        )
      end
    end

    context "unauthenticated" do
      it "return 401" do
        get api_v1_rides_path(format: :json), headers: headers
        expect(response.status).to eq(401)
      end
    end
  end
end