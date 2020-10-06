require 'rails_helper'

feature 'User can edit  his answer', %q{
  In order to correct mistakes
  As an author  of answer
  I'd like to be able to edit my answer
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe "Authenticated user", js: true do
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

    scenario 'edits his answer with errors' do

    end
  end

  describe "Unauthenticated user" do
    scenario "can't edit answer" do
      visit questions_path(question)

      expect(page).to_not have_link 'Edit'
    end
  end
end
