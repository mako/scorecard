FactoryBot.define do
  factory :pull_request do
    id { Faker::Number.number(digits: 4) }
    association :user
    state { 1 }
    score { 12 }
    created { Faker::Time.backward(days: 14, period: :evening) }
  end
end