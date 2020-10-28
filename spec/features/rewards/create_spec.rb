require 'rails_helper'

feature 'User can create reward', "
  In order to give reward to a question
  As an authenticated user
  I'd like to be able to give reward to a question
" do
  given(:user) { create(:user) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit new_question_path
    end

    scenario 'tries to ask a question with reward' do
      fill_in 'Title', with: 'title1'
      fill_in 'Body', with: 'body1'

      within '#best-answer-reward' do
        fill_in 'Reward', with: 'BEST'
        attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      end
      click_on 'Ask'

      expect(page).to have_content 'BEST'
    end
  end
end
