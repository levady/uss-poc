module Api
  class BaseController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    private

    def render_validation_error(errors)
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end
end
