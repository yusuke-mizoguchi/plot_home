FactoryBot.define do
  factory :review do
    sequence(:good_point) { |n| "good-#{n}"}
    sequence(:bad_point) { |n| "bad-#{n}"}
    sequence(:comment) { |n| "comment-#{n}" }
    association :user
    association :novel

    trait :comment do
      sequence(:good_point) { |n| "reply-#{n}" }
      sequence(:comment) { |n| "comment-#{n}" }
    end
  end
end
