FactoryBot.define do
  factory :answer do
    body { 'MyAnswerBody' }
    question
    user

    trait :invalid do
      body { nil }
      question
      user
    end

    trait :file do
      before :create do |answer|
        answer.files.attach Rack::Test::UploadedFile.new("#{Rails.root}/spec/rails_helper.rb")
      end
    end
  end
end
