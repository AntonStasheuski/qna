require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:gist_url) { 'https://gist.github.com/AntonStashevski/d5d415a420a6f97d687c3bf8d2c1c568' }

  scenario 'User adds link when ask answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'body1'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Link url', with: gist_url

    click_on 'Answer'

    expect(page).to have_link 'My gist', href: gist_url
  end

  scenario 'User adds links when ask answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'body1'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Link url', with: gist_url

    click_on 'Add link'

    fill_in 'Link name', with: 'My gist2'
    fill_in 'Link url', with: gist_url

    click_on 'Answer'

    expect(page).to have_link 'My gist2', href: gist_url
    expect(page).to have_link 'My gist', href: gist_url
  end
end
