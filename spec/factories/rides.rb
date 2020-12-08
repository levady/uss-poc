FactoryBot.define do
  factory :ride do
    sequence(:name) { |n| "ride-#{n}" }
    capacity { 40 }
    duration { 5 }
    sequence(:sensor_code) { |n| "ride-#{n}" }
  end
end
