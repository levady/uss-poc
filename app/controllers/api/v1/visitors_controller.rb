module Api
  module V1
    # TODO: use metal controller
    class VisitorsController < ::Api::BaseController
      def create
        VisitorWorker.perform_async(
          create_params[:sensor_code],
          create_params[:visitors_count],
          create_params[:collected_at]
        )
        head :ok
      end

    private
      
      def create_params
        params.require(:visitor).permit(:sensor_code, :visitors_count, :collected_at)
      end
    end
  end
end