require 'rails_helper'

feature 'User can create answer', %q{
  In order to give an answer to a question
  As an authenticated user
  I'd like to be able to give an answer to a question
} do

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

    scenario 'tries to answer with errors' do
      click_on 'Answer'

      expect(page).to have_content "Body can't be blank"
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