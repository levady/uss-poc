class VisitorDataCollector
  include ActiveModel::Validations

  attr_reader :ride, :sensor_code, :visitors_count, :collected_at

  validates :sensor_code, :visitors_count, :collected_at, presence: true

  def initialize(sensor_code, visitors_count, collected_at)
    @sensor_code = sensor_code
    @visitors_count = visitors_count
    @collected_at = collected_at
    validate!
  end
  
  def run!
    @ride = Ride.find_by!(sensor_code: sensor_code)
    
    Visitor.upsert(
      { ride_id: ride.id, visitors_count: visitors_count, collected_at: collected_at },
      returning: %w[ id ride_id visitors_count collected_at ],
      unique_by: %i[ ride_id visitors_count collected_at ]
    )
  end
end