require 'rails_helper'

feature 'User can edit  his answer', "
  In order to correct mistakes
  As an author  of answer
  I'd like to be able to edit my answer
" do
  given!(:user) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user', js: true do
    scenario 'edits his answer' do
      sign_in user
      visit question_path(question)
      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer', with: 'edited'
        click_on 'Create'
        expect(page).to_not have_content(answer.body)
        expect(page).to have_content('edited')
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'but not author trying to edit' do
      sign_in(user2)
      visit question_path(question)
      expect(page).to_not have_selector(:link_or_button, 'Edit')
    end

    scenario 'edits his answer with errors' do
      sign_in user
      visit question_path(question)
      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer', with: ''
        click_on 'Create'
      end
      expect(page).to have_content("Body can't be blank")
    end
  end

  describe 'Unauthenticated user' do
    scenario "can't edit answer" do
      visit questions_path(question)

      expect(page).to_not have_link 'Edit'
    end
  end
end
