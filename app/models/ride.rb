class Ride < ApplicationRecord
  validates :name, :status, :capacity, :duration, :sensor_code, presence: true
  has_many :visitors
end
