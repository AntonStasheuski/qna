require 'rails_helper'

feature 'User can see question answers', "
  In order to see answers to a question
  As an any user
  I'd like to be able to see answers to a question
" do
  given(:answer) { create(:answer) }
  describe 'Unauthenticated user' do
    scenario 'User tries to see a answers to a question' do
      visit question_path(answer.question)

      expect(page).to have_content answer.body
    end
  end

  describe 'Authenticated user' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario " can't create answer to a question with valid attr" do
      visit question_path(answer.question)
      fill_in 'Body', with: 'body1'
      click_on 'Answer'

      expect(page).to have_content 'body1'
    end

    scenario ' create answer to a question with invalid attr', js: true do
      visit question_path(answer.question)
      click_on 'Answer'

      expect(page).to have_content "Body can't be blank"
    end
  end
end
