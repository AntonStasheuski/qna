require 'rails_helper'

feature 'User can add gists to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, :gist) }
  given(:answer) { create(:answer, :gist) }
  given(:answer2) { create(:answer, :link) }

  before do
    sign_in(user)
    visit question_path(question)
  end

  describe 'Question' do
    scenario 'User can see gist content on Question', js: true do
      expect(page).to have_content 'Gist for qna project'
    end
  end

  describe 'Answer' do
    scenario 'User can see gist content on Question', js: true do
      expect(page).to have_content 'Gist for qna project'
    end
  end

  describe 'Methods' do
    context 'gist?' do
      it { expect(answer.links.first.gist?).to be_truthy }
      it { expect(answer2.links.first.gist?).to be_falsey }
    end
  end
end
  
