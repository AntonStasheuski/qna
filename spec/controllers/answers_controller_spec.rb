require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  describe 'GET #index' do
    let(:answers) { create_list(:answer, 1) }

    before { get :index, params: { question_id: answers.first.question } }

    it 'populates an array of all answers for the question' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

end
