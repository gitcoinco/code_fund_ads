class PropertyInstructionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property

  private

  def set_property
    @property = if authorized_user.can_admin_system?
      Property.find_by(id: params[:property_id])
    else
      current_user.properties.find_by(id: params[:property_id])
    end
    render_not_found unless @property
  end
end
