require 'rails_helper'

RSpec.describe Ride, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:capacity) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:sensor_code) }

  it { should have_many(:visitors) }
end
