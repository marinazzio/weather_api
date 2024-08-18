FactoryBot.define do
  factory :measure do
    city
    timestamp { Time.zone.now }
    temperature { rand(-30.0..30.0) }
  end
end
