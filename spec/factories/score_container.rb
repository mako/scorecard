class ScoreContainer
  attr_accessor :year, :week, :total_score, :scores
end
FactoryBot.define do
  factory :score_container, class: ScoreContainer do
    year { Faker::Time.backward(days: 14, period: :evening) }
    week { Faker::Number.number(digits: 1) }
    total_score { Faker::Number.number(digits: 2) }
    trait :with_scores do
      scores { build_list :score, 3 }
    end
    skip_create
  end
end
