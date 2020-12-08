require 'rails_helper'

RSpec.describe Visitor, type: :model do
  it { should validate_presence_of(:ride_id) }
  it { should validate_presence_of(:visitors_count) }
  it { should validate_presence_of(:collected_at) }
end
