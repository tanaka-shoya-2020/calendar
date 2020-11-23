FactoryBot.define do
  factory :sample do
    title { Faker::Lorem.word }
    start_time { '2020-11-22 05:57:00' }
    end_time { '2020-11-22 05:57:00' }
    body { Faker::Lorem.sentence }
  end
end