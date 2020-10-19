require 'rails_helper'

feature 'User can edit attachment', "
  In order to edit attachment to a question/answer
  As an authenticated user
  I'd like to be able to give attachment to a question/answer
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, :file, question: question, user: user) }

  describe 'Authenticated user', js: true do
    describe 'Answer' do
      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'edit his answer with changing file' do
        click_on 'Edit'

        within '.answers' do
          attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

          click_on 'Create'
          expect(page).to have_link 'spec_helper.rb'
          expect(page).to have_content(answer.body)
          expect(page).to_not have_selector 'textarea'
        end
      end

      scenario 'edits his answer with changing files' do
        click_on 'Edit'

        within '.answers' do
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

          click_on 'Create'
          expect(page).to have_link 'rails_helper.rb'
          expect(page).to have_link 'spec_helper.rb'
          expect(page).to have_content(answer.body)
          expect(page).to_not have_selector 'textarea'
        end
      end
    end

    # describe 'Question', js: true do
    #   background do
    #     sign_in(user)
    #     visit new_question_path
    #   end
    # end
  end
end
