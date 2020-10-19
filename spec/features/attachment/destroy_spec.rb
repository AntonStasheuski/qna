require 'rails_helper'

feature 'User can delete attachment', "
  In order to give attachment to a question/answer
  As an authenticated user
  I'd like to be able to delete attachment to a question/answer
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, :file, user: user) }
  given!(:answer) { create(:answer, :file, question: question, user: user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  describe 'Authenticated user', js: true do
    describe 'Answer' do

      scenario 'tries to delete a attachment from answer' do
        within '.answers' do
          click_on 'Delete file'
          expect(page).to_not have_link 'Delete file'
        end
      end
    end
  end

  describe 'Question', js: true do
    scenario 'tries to delete a attachment from question' do

      within '.question' do
        click_on 'Delete file'
        expect(page).to_not have_link 'Delete file'
      end
    end
  end
end
