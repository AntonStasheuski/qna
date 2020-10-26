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

    trait :link do
      before :create do |answer|
        answer.links.new(name: "test", url: "https://www.test.com/").save!
      end
    end

  end
end
