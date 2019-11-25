class CreativePreviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_creative
  layout false

  private

  def set_creative
    @creative = if authorized_user.can_admin_system?
      Creative.find(params[:creative_id])
    else
      current_user.creatives.find(params[:creative_id])
    end
  end
end
