class WaitTimeCalculator
  WAIT_TIME_QUERY = "
  SELECT
    rides.id,
    name,
    status,
    (CASE WHEN SUM(visitors_count) IS NULL OR SUM(visitors_count) < 0 THEN 0 ELSE SUM(visitors_count) END) AS number_of_people, 
    ((sum(visitors_count) / capacity) * duration) AS estimated_wait_time
  FROM rides
  LEFT JOIN visitors ON rides.id = visitors.ride_id
    AND collected_at >= ? AND collected_at <= ?
  GROUP BY
    rides.id
  ORDER BY
    rides.id".freeze

  def estimate_all_rides(eval_time=Time.now)
    Ride.find_by_sql([WAIT_TIME_QUERY, eval_time.beginning_of_day, eval_time.end_of_day]).map do |ride|
      ride.attributes
    end
  end
end