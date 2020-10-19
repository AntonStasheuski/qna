require 'rails_helper'

feature 'User can delete attachment', "
  In order to give attachment to a question/answer
  As an authenticated user
  I'd like to be able to delete attachment to a question/answer
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, :file, question: question, user: user) }

  describe 'Authenticated user', js: true do
    describe 'Answer' do
      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'tries to delete a attachment from answer' do
        within '.attachments' do
          click_on 'Delete file'
        end
        expect(page).to_not have_link 'Delete file'
      end
    end
  end
end
