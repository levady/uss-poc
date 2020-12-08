module Api
  class BaseController < ActionController::Base
    before_action :basic_authenticate

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    delegate :secure_compare, to: ActiveSupport::SecurityUtils

    private

    def basic_authenticate
      authenticated = authenticate_with_http_basic do |u, p| 
        secure_compare(u, ENV["BASIC_AUTH_USER"].to_s) && secure_compare(p, ENV["BASIC_AUTH_PASSWORD"].to_s)
      end
      request_http_basic_authentication unless authenticated
    end

    def render_validation_error(errors)
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end
end
