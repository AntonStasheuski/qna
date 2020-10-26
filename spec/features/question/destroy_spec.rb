require 'rails_helper'

feature 'User can delete question', "
  In order to delete a question
  As an authenticated user
  I'd like to be able to delete a question
" do
  given(:user1) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user1) }

  describe 'Authenticated user' do
    scenario 'author of a question and he try to delete it' do
      sign_in(user1)
      visit question_path(question)
      click_on 'Delete'
      expect(page).to have_content 'Your question successfully deleted.'
    end

    scenario 'not author of a question and he try to delete it' do
      sign_in(user2)
      visit question_path(question)
      within '.question' do
        expect(page).to_not have_selector(:link_or_button, 'Delete')
      end
    end
  end

  describe 'Unauthenticated user' do
    scenario 'try to delete question' do
      visit question_path(question)
      within '.question' do
        expect(page).to_not have_selector(:link_or_button, 'Delete')
      end
    end
  end
end
