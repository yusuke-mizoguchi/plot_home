FactoryBot.define do
  factory :novel do
    sequence(:title) { |n| "title-#{n}"}
    genre { :high_fantasy }
    story_length { :long }
    release { :release }
    association :user

    trait do
      sequence(:title) { |n| "title-#{n}"}
      genre { :low_fantasy }
      story_length { :middle }
      release { :reader }
    end

    trait do
      sequence(:title) { |n| "title-#{n}"}
      genre { :classic }
      story_length { :middle }
      release { :writer }
    end

    trait do
      sequence(:title) { |n| "title-#{n}"}
      genre { :love }
      story_length { :short }
      release { :draft }
    end
  end
end
