require 'rails_helper'

feature 'User can log out', %q{
  I'd like to be able to log out
} do

  given(:user) { create(:user) }

  background { sign_in user }

  scenario 'Authenticated user log out' do
    click_on 'Log out'
    expect(page).to have_content 'Signed out successfully.'
  end
end