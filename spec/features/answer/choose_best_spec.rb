require 'rails_helper'

feature 'User can choose best answer', "
  In order to choose best answer to a question
  As an authenticated user
  I'd like to be able to choose best answer to a question
" do
  given!(:user1) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:question) { create(:question, user: user1) }
  given!(:answer) { create(:answer, question: question, user: user1) }

  describe 'Authenticated user' do
    scenario 'user author of the question', js: true do
      sign_in(user1)
      visit question_path question

      expect(page).to have_selector(:link_or_button, 'Mark as best')

      click_on 'Mark as best'

      expect(page).to have_selector(:link_or_button, 'Unmark as best')
    end

    scenario 'user not author of the question' do
      sign_in(user2)
      visit question_path question

      expect(page).to_not have_selector(:link_or_button, 'Mark as best')
    end
  end

  scenario 'Unauthenticated user' do
    visit question_path(question)

    expect(page).to_not have_selector(:link_or_button, 'Mark as best')
  end
end
