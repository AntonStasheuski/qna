class LinksController < ApplicationController
  before_action :find_link, only: %i[destroy]

  def destroy
    if current_user.author? @link.linkable
      @link.destroy
      flash[:notice] = 'Your link successfully deleted.'
    end
  end

  private

  def find_link
    @link = Link.find(params[:id])
  end
end
