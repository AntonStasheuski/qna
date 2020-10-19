FactoryBot.define do
  factory :question do
    title { 'MyQuestionTitle' }
    body { 'MyQuestionBody' }
    user

    trait :invalid do
      title { nil }
      user
    end

    trait :file do
      before :create do |question|
        question.files.attach Rack::Test::UploadedFile.new("#{Rails.root}/spec/rails_helper.rb")
      end
    end
  end
end
