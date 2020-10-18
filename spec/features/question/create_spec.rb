require 'rails_helper'

feature 'User can create question', "
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask a question
" do
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit questions_path
      click_on 'Ask question'
    end

    scenario 'tries to ask a question' do
      fill_in 'Title', with: 'title1'
      fill_in 'Body', with: 'body1'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'title1'
      expect(page).to have_content 'body1'
    end

    scenario 'tries to ask a question with errors' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end

    scenario 'tries to ask a question with attached file' do
      fill_in 'Title', with: 'title1'
      fill_in 'Body', with: 'body1'

      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Ask'

      expect(page).to have_link "rails_helper.rb"
    end

    scenario 'tries to ask a question with attached files' do
      fill_in 'Title', with: 'title1'
      fill_in 'Body', with: 'body1'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Ask'

      expect(page).to have_link "rails_helper.rb"
      expect(page).to have_link "spec_helper.rb"
    end
  end

  scenario 'Unauthenticated user tries to ask a question with errors' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
