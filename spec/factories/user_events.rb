FactoryBot.define do
  factory :user_event do
    title { Faker::Lorem.word }
    date = Date.today
    start_time { "#{date} 05:57:00" }
    body { Faker::Lorem.sentence }
    association :user
  end
end
