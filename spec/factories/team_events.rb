FactoryBot.define do
  factory :team_event do
    title { Faker::Lorem.word }
    start_time { '2020-11-22 05:57:00' }
    body { Faker::Lorem.sentence }
    association :team
  end
end
