require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let!(:question1) { create(:question, :file, user: user) }
  let!(:file) { question1.files.first }

  describe 'Authorized user' do
    describe 'DELETE #destroy' do
      context 'Author' do
        before { login(user) }
        it ' delete the attachment' do
          expect { delete :destroy, params: { id: file }, format: :js }.to change(ActiveStorage::Attachment, :count).by(-1)
        end
      end

      context 'Not author' do
        before { login(user1) }
        it ' tries to delete the attachment' do
          expect { delete :destroy, params: { id: file }, format: :js }.not_to change(ActiveStorage::Attachment, :count)
        end
      end
    end
  end

  describe 'Unauthorized user' do
    it " can't delete attachment" do
      expect { delete :destroy, params: { id: file }, format: :js }.not_to change(ActiveStorage::Attachment, :count)
    end
  end
end
