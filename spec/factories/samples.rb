FactoryBot.define do
  factory :sample do
    title { Faker::Lorem.word }
    date = Date.today
    start_time { "#{date} 05:57:00" }
    body { Faker::Lorem.sentence }
  end
end
