FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user-#{n}" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    role { :writer }
    admin { false }

    trait :writer do
      sequence(:name) { |n| "wtiter-#{n}" }
      sequence(:email) { |n| "write-#{n}@example.com" }
      role { :writer }
    end

    trait :reader do
    sequence(:name) { |n| "reader-#{n}" }
    sequence(:email) { |n| "read-#{n}@example.com" }
    role { :reader }
    end
  end
end
