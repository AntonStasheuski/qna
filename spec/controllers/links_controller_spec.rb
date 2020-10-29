require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let!(:question) { create(:question, :link, user: user) }
  let!(:link) { question.links.first }

  describe 'Authorized user' do
    describe 'DELETE #destroy' do
      context 'Author' do
        before { login(user) }
        it ' delete the link' do
          expect { delete :destroy, params: { id: link }, format: :js }.to change(Link, :count).by(-1)
        end
      end

      context 'Not author' do
        before { login(user1) }
        it ' tries to delete the link' do
          expect { delete :destroy, params: { id: link }, format: :js }.not_to change(Link, :count)
        end
      end
    end
  end

  describe 'Unauthorized user' do
    it " can't delete link" do
      expect { delete :destroy, params: { id: link }, format: :js }.not_to change(Link, :count)
    end
  end
end
