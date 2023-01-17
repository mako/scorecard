class Score
  attr_accessor :login_name, :score
end
FactoryBot.define do
  factory :score, class: Score do
    login_name { Faker::Internet.username(specifier: 5..10) }
    score { Faker::Number.number(digits: 1) }
    skip_create
  end
end
