FactoryBot.define do
  factory :review do
    sequence(:good_point) { |n| "good-#{n}"}
    sequence(:bad_point) { |n| "bad-#{n}"}
    association :user
    association :novel
    association :parent, class_name: 'Review'

    trait :comment do
      sequence(:good_point) { |n| "reply-#{n}" }
      sequence(:comment) { |n| "comment-#{n}" }
    end
  end
end
