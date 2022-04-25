FactoryBot.define do
  factory :notification do
    association :visited, class_name: 'User', optional: true
    association :visitor, class_name: 'User', optional: true
    association :novel, optional: true
    association :review, optional: true
  end
end
