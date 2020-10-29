require 'rails_helper'

feature 'User can create attachment', "
  In order to give attachment to a question/answer
  As an authenticated user
  I'd like to be able to give attachment to a question/answer
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user', js: true do
    describe 'Answer' do
      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'tries to ask a answer with attached file' do
        fill_in 'Body', with: 'body1'

        attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
        click_on 'Answer'

        expect(page).to have_link 'rails_helper.rb'
      end

      scenario 'tries to ask a answer with attached files' do
        fill_in 'Body', with: 'body1'

        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Answer'

        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end

    describe 'Question', js: true do
      background do
        sign_in(user)
        visit new_question_path
      end

      scenario 'tries to ask a question with attached file' do
        fill_in 'Title', with: 'title1'
        fill_in 'Body', with: 'body1'

        within '.new-question' do
          attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
        end

        click_on 'Ask'
        expect(page).to have_link 'rails_helper.rb'
      end

      scenario 'tries to ask a question with attached files' do
        fill_in 'Title', with: 'title1'
        fill_in 'Body', with: 'body1'
        within '.new-question' do
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        end

        click_on 'Ask'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end
  end
end
