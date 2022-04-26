FactoryBot.define do
  factory :review do
    sequence(:good_point) { |n| "good-#{n}"}
    sequence(:bad_point) { |n| "bad-#{n}"}
    comment { "Review" }
    association :user
    association :novel

    trait :comment do
      good_point { "Reply" }
      sequence(:comment) { |n| "comment-#{n}" }
    end
  end
end
