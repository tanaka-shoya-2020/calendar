FactoryBot.define do
  factory :user_event do
    title { Faker::Lorem.word }
    start_time { '2020-11-22 05:57:00' }
    body { Faker::Lorem.sentence }
    association :user
  end
end
