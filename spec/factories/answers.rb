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

    trait :gist do
      before :create do |answer|
        answer.links.new(name: "gist", url: "https://gist.github.com/AntonStashevski/d5d415a420a6f97d687c3bf8d2c1c568").save!
      end
    end

  end
end
