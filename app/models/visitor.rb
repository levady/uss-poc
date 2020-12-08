class Visitor < ApplicationRecord
  validates :ride_id, :visitors_count, :collected_at, presence: true
  belongs_to :ride
end
