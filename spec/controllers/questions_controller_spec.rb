require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  context 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  context 'GET #show' do
    before { get :show, params: { id: question } }

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe "Authorized user" do
    let(:user) { create(:user) }
    before { login(user) }

    context 'GET #new' do
      before { get :new }

      it 'render new view' do
        expect(response).to render_template :new
      end
    end

    context 'GET #edit' do
      before { get :edit, params: { id: question } }

      it 'render edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'POST #create' do

      context 'with valid attributes' do
        it 'save a new question' do
          expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
        end
        it 'redirect to show view' do
          post :create, params: { question: attributes_for(:question) }
          expect(response).to redirect_to assigns(:question)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect { post :create, params: { question: attributes_for(:question, :invalid) } }.to_not change(Question, :count)
        end
        it 're-render new view' do
          post :create, params: { question: attributes_for(:question, :invalid) }
          expect(response).to render_template :new
        end
      end
    end

    context 'PATCH #update' do

      context 'with valid attributes' do
        it 'assigns the requested question to @question' do
          patch :update, params: { id: question, question: attributes_for(:question) }
          expect(assigns(:question)).to eq question
        end
        it 'change question attributes' do
          patch :update, params: { id: question, question: { title: 'title2', body: 'body2' } }
          question.reload

          expect(question.title).to eq 'title2'
          expect(question.body).to eq 'body2'
        end
        it 'redirect to  updated question' do
          patch :update, params: { id: question, question: attributes_for(:question) }
          expect(response).to redirect_to question
        end
      end

      context 'with invalid attributes' do
        before { patch :update, params: { id: question, question: attributes_for(:question, :invalid) } }
        it 'does not change question attributes' do
          question.reload

          expect(question.title).to eq 'MyQuestionTitle'
          expect(question.body).to eq 'MyQuestionBody'
        end

        it 're-render edit view' do
          expect(response).to render_template :edit
        end
      end

      context 'DELETE #destroy' do

        let!(:question) { create(:question, user: user) }

        it 'delete the question' do
          expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
        end

        it 'redirects to index' do
          delete :destroy, params: { id: question }
          expect(response).to redirect_to questions_path
        end
      end
    end
  end

  describe "Unauthorized user" do
    shared_examples "redirect" do |path|
      it "#{path} action to sign in" do
        expect(@response).to redirect_to new_user_session_path
      end
    end

    context 'GET #new' do
      before do
        get :new
        @response = response
      end
      it_behaves_like "redirect", "new"
    end

    context 'GET #edit' do
      before do
        get :edit, params: { id: question }
        @response = response
      end
      it_behaves_like "redirect", "edit"
    end

    context 'POST #create' do
      before do
        post :create, params: { question: attributes_for(:question) }
        @response = response
      end
      it_behaves_like "redirect", "create"
    end

    context 'PATCH #update' do
      before do
        patch :update, params: { id: question, question: attributes_for(:question) }
        @response = response
      end
      it_behaves_like "redirect", "update"
    end

    context 'DELETE #destroy' do
      before do
        delete :destroy, params: { id: question }
        @response = response
      end
      it_behaves_like "redirect", "update"
    end
  end
end
