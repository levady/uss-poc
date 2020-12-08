module Api
  module V1
    class VisitorsController < ::Api::BaseController
      def create
        VisitorDataCollector.new(
          create_params[:sensor_code],
          create_params[:visitors_count],
          create_params[:collected_at]
        ).run!
        head :ok
      rescue ActiveRecord::RecordNotFound
        head :internal_server_error
      rescue ActiveModel::ValidationError => e
        render_validation_error(e)
      end

    private
      
      def create_params
        params.require(:visitor).permit(:sensor_code, :visitors_count, :collected_at)
      end
    end
  end
end