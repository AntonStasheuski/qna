require 'rails_helper'

feature 'User can see the list of answers to the question', "
  I'd like to be able to see list of answers
" do
  given!(:answer) { create(:answer) }

  scenario 'User can see list of all answers to the question' do
    visit question_answers_path(answer.question)

    expect(page).to have_content answer.body
  end
end
