FactoryBot.define do
  factory :review do
    sequence(:good_point) { |n| "good-#{n}"}
    sequence(:bad_point) { |n| "bad-#{n}"}
    association :user
    association :novel
  end
end
