require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:url) { 'https://www.google.com/' }

  scenario 'User adds link when ask answer' do
    sign_in(user)
    visit question_path(question)
    within '.new-answer' do
      fill_in 'Body', with: 'body1'

      fill_in 'Link name', with: 'Google'
      fill_in 'Link url', with: url

      click_on 'Answer'
    end

    expect(page).to have_link 'Google', href: url
  end

  scenario 'User adds links when ask answer' do
    sign_in(user)
    visit question_path(question)

    within '.new-answer' do
      fill_in 'Body', with: 'body1'

      fill_in 'Link name', with: 'Google'
      fill_in 'Link url', with: url

      click_on 'Add link'

      fill_in 'Link name', with: 'Google2'
      fill_in 'Link url', with: url

      click_on 'Answer'
    end
    expect(page).to have_link 'Google', href: url
    expect(page).to have_link 'Google2', href: url
  end
end
