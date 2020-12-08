FactoryBot.define do
  factory :visitor do
    association :ride
    visitors_count { rand(50) + 1 }
    collected_at { Time.now }
  end
end
