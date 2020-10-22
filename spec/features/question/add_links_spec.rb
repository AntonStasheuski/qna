require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do
  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/AntonStashevski/d5d415a420a6f97d687c3bf8d2c1c568' }

  scenario 'User adds links when ask question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'title1'
    fill_in 'Body', with: 'body1'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    expect(page).to have_link 'My gist', href: gist_url
  end
end
