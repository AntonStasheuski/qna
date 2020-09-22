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

  describe 'GET #show' do
    let(:answer) { create(:answer) }

    before { get :show, params: { question_id: answer.question, id: answer } }

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    let(:question) { create(:question) }

    context 'with valid attributes' do
      it 'save a new answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(Answer, :count).by(1)
      end
      it 'redirect to show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_answer_path(question_id: question, id: question.answers.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
      end
      it 're-render new view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #new' do
    let(:question) { create(:question) }

    before { get :new, params: { question_id: question } }

    it 'render new view' do
      expect(response).to render_template :new
    end
  end
end
