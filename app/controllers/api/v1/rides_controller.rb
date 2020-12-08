module Api
  module V1
    class RidesController < ::Api::BaseController
      def index
        render json: WaitTimeCalculator.new.estimate_all_rides
      end
    end
  end
end