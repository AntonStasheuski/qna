require 'rails_helper'

feature 'User can delete answer', "
  In order to delete a answer
  As an authenticated user
  I'd like to be able to delete a answer
" do
  given(:user1) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user1) }
  given!(:answer) { create(:answer, question: question, user: user1) }

  describe 'Authenticated user', js: true do
    scenario 'author of the question and he is trying to delete it' do
      sign_in(user1)
      visit question_path(answer.question)
      within '.answers' do
        click_on 'Delete'
      end
      expect(page).to have_content 'Your answer successfully deleted.'
    end

    scenario 'not author of the question and he is trying to delete it' do
      sign_in(user2)
      visit question_path(answer.question)
      expect(page).to_not have_selector(:link_or_button, 'Delete')
    end
  end

  describe 'Unauthenticated user' do
    scenario 'try to delete question' do
      visit question_path(answer.question)
      expect(page).to_not have_selector(:link_or_button, 'Delete')
    end
  end
end
