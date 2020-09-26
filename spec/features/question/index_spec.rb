require 'rails_helper'

feature 'User can see the list of questions', %q{
  I'd like to be able to see list of questions
} do

  given!(:question) { create(:question) }

  scenario 'User can see list of all questions' do
    visit questions_path

    expect(page).to have_content question.title
  end

end