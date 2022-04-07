FactoryBot.define do
  factory :character do
    character_role { 'test_role' }
    character_text { 'test_text' }
    association :novel
  end
end
