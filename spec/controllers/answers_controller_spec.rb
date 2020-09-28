require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  context 'GET #index' do
    let(:answers) { create_list(:answer, 1) }

    before { get :index, params: { question_id: answers.first.question } }

    it 'populates an array of all answers for the question' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  context 'GET #show' do
    let(:answer) { create(:answer) }

    before { get :show, params: { question_id: answer.question, id: answer } }

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe "Authorized user" do
    let(:user) { create(:user) }

    before { login(user) }

    context 'GET #new' do
      let(:answer) { create(:answer) }

      before { get :new, params: { question_id: answer.question, id: answer } }

      it 'render new view' do
        expect(response).to render_template :new
      end
    end

    context 'GET #edit' do
      let(:answer) { create(:answer) }

      before { get :edit, params: { question_id: answer.question, id: answer } }

      it 'render edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'POST #create' do
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
          expect(response).to render_template 'questions/show'
        end
      end
    end

    context 'PATCH #update' do
      let(:answer) { create(:answer) }

      context 'with valid attributes' do
        it 'assigns the requested answer to @answer' do
          patch :update, params: { question_id: answer.question, id: answer, answer: attributes_for(:answer) }
          expect(assigns(:answer)).to eq answer
        end
        it 'change answer attributes' do
          patch :update, params: { question_id: answer.question, id: answer, answer: { body: 'body2' } }
          answer.reload

          expect(answer.body).to eq 'body2'
        end
        it 'redirect to updated answer' do
          patch :update, params: { question_id: answer.question, id: answer, answer: attributes_for(:answer) }
          expect(response).to redirect_to question_answer_path(question_id: answer.question, id: answer)
        end
      end

      context 'with invalid attributes' do
        before { patch :update, params: { question_id: answer.question, id: answer, answer: attributes_for(:answer, :invalid) } }
        it 'does not change answer attributes' do
          answer.reload

          expect(answer.body).to eq 'MyAnswerBody'
        end

        it 're-render edit view' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'DELETE #destroy' do
      let!(:answer) { create(:answer, user: user) }

      it 'delete the answer' do
        expect { delete :destroy, params: { question_id: answer.question, id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { question_id: answer.question, id: answer }
        expect(response).to redirect_to question_answers_path(question_id: answer.question)
      end
    end
  end

  describe "Unauthorized user" do
    let(:answer) { create(:answer) }
    let(:question) { create(:question) }

    shared_examples "redirect" do |path|
      it "#{path} action to sign in" do
        expect(@response).to redirect_to new_user_session_path
      end
    end

    context 'GET #new' do
      before do
        get :new, params: { question_id: answer.question, id: answer }
        @response = response
      end
      it_behaves_like "redirect", "new"
    end

    context 'GET #edit' do
      before do
        get :edit, params: { question_id: answer.question, id: answer }
        @response = response
      end
      it_behaves_like "redirect", "edit"
    end

    context 'POST #create' do
      before do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        @response = response
      end
      it_behaves_like "redirect", "create"
    end

    context 'PATCH #update' do
      before do
        patch :update, params: { question_id: answer.question, id: answer, answer: attributes_for(:answer) }
        @response = response
      end
      it_behaves_like "redirect", "update"
    end

    context 'DELETE #destroy' do
      before do
        delete :destroy, params: { question_id: answer.question, id: answer }
        @response = response
      end
      it_behaves_like "redirect", "update"
    end
  end

end
