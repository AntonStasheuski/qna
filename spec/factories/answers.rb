FactoryBot.define do
  factory :answer do
    body { 'MyAnswerBody' }
    question
    trait :invalid do
      body { nil }
      question
    end
  end
end
