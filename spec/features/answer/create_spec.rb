require 'rails_helper'

feature 'User can create answer', "
  In order to give an answer to a question
  As an authenticated user
  I'd like to be able to give an answer to a question
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'tries to answer' do
      fill_in 'Body', with: 'body1'
      click_on 'Answer'

      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'body1'
    end

    scenario 'tries to answer with errors', js: true do
      click_on 'Answer'

      expect(page).to have_content "Body can't be blank"
    end

    scenario 'tries to ask a answer with attached file' do
      fill_in 'Body', with: 'body1'

      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Answer'

      expect(page).to have_link "rails_helper.rb"
    end

    scenario 'tries to ask a answer with attached files' do
      fill_in 'Body', with: 'body1'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Answer'

      expect(page).to have_link "rails_helper.rb"
      expect(page).to have_link "spec_helper.rb"
    end
  end

  describe 'Unauthenticated user' do
    background { visit question_path(question) }

    scenario 'tries to answer with errors' do
      click_on 'Answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
