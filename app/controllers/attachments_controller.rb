class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_attachment, only: %i[destroy]

  def destroy
    if current_user.author? @attachment.record
      @attachment.purge
      flash[:notice] = 'Your attachment successfully deleted.'
    end
  end

  private

  def find_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end
end
