class VisitorWorker
  include Sidekiq::Worker

  def perform(sensor_code, visitors_count, collected_at)
    VisitorDataCollector.new(sensor_code, visitors_count, collected_at).run!
  rescue ActiveRecord::RecordNotFound, ActiveModel::ValidationError => e
    # TODO: send to error tracker
    Rails.logger.error("visitor data collector error: #{e.message}")
  end
end
