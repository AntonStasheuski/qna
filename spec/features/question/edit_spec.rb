require 'rails_helper'

feature 'User can edit  his answer', "
  In order to correct mistakes
  As an author  of answer
  I'd like to be able to edit my answer
" do
  given!(:user) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:gist_url) { 'https://gist.github.com/AntonStashevski/d5d415a420a6f97d687c3bf8d2c1c568' }

  describe 'Authenticated user', js: true do
    scenario 'edits his question' do
      sign_in user
      visit question_path(question)

      within '.question' do
        click_on 'Edit'
        fill_in 'Title', with: 'edited'
        fill_in 'Body', with: 'edited'
        click_on 'Create'
        expect(page).to_not have_content(question.body)
        expect(page).to have_content('edited')
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'but not author trying to edit' do
      sign_in(user2)
      visit question_path(question)
      expect(page).to_not have_selector(:link_or_button, 'Edit')
    end

    scenario 'edits his question with errors' do
      sign_in user
      visit question_path(question)
      click_on 'Edit'

      within '.question' do
        fill_in 'Title', with: ''
        click_on 'Create'
      end
      expect(page).to have_content("Title can't be blank")
    end


    scenario 'add links to question' do
      sign_in user
      visit question_path(question)

      within '.question' do
        click_on 'Edit'
        fill_in 'Title', with: 'edited'
        click_on 'Add link'
        fill_in 'Link name', with: 'My gist'
        fill_in 'Link url', with: gist_url
        click_on 'Create'
        expect(page).to have_link 'My gist', href: gist_url
      end
    end
  end

  describe 'Unauthenticated user' do
    scenario "can't edit question" do
      visit questions_path(question)

      expect(page).to_not have_link 'Edit'
    end
  end
end
