require 'rails_helper'

feature 'User can delete links drom answer', %q{
  In order to delete additional link to my answer
  As an answer's author
  I'd like to be able to delete links
} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, :link, user: user, question: question) }
  describe 'Author' do
    scenario ' delete link from answer', js: true do
      sign_in(user)
      visit question_path(question)
      within '.links' do
        click_on 'Delete link'
        expect(page).to_not have_link 'test', href: "https://www.test.com/"
      end
    end
  end

  describe 'Not author' do
    scenario " can't delete link from answer", js: true do
      sign_in(user2)
      visit question_path(question)
      expect(page).to_not have_selector(:link_or_button, 'Delete link')
    end
  end

end
