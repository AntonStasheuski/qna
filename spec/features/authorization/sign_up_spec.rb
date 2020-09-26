require 'rails_helper'

feature 'User can register', "
  In order if i haven't account
  As an unauthenticated User
  I'd like to be able to register
" do
  describe 'Not registered' do
    scenario 'user can sign up account with valid params' do
      visit new_user_registration_path

      fill_in 'Email', with: 'valid@test.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    scenario "user can't sign up account with invalid attrs" do
      visit new_user_registration_path
      click_on 'Sign up'

      expect(page).to have_content "Email can't be blank"
    end
  end

  describe 'Registered' do
    given(:user) { create(:user) }

    scenario 'user try to register an account for busy mail' do
      visit new_user_registration_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'

      expect(page).to have_content 'Email has already been taken'
    end
  end
end
