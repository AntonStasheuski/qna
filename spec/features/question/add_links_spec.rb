require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do
  given(:user) { create(:user) }
  given(:url) { 'https://www.google.com/' }

  scenario 'User adds links when ask question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'title1'
    fill_in 'Body', with: 'body1'

    fill_in 'Link name', with: 'Google'
    fill_in 'Link url', with: url

    click_on 'Ask'

    expect(page).to have_link 'Google', href: url
  end

  scenario 'User adds links when ask question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'title1'
    fill_in 'Body', with: 'body1'

    fill_in 'Link name', with: 'Google'
    fill_in 'Link url', with: url

    click_on 'Add link'

    fill_in 'Link name', with: 'Google2'
    fill_in 'Link url', with: url

    click_on 'Ask'

    expect(page).to have_link 'Google', href: url
    expect(page).to have_link 'Google2', href: url
  end
end
