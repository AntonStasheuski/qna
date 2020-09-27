FactoryBot.define do
  factory :question do
    title { 'MyQuestionTitle' }
    body { 'MyQuestionBody' }
    user

    trait :invalid do
      title { nil }
    end
  end
end
