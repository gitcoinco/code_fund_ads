class PropertyCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_view!, only: :index
  before_action :set_property, only: :index

  def index
    @comments = @property.comment_threads.order(created_at: :desc)
  end

  private

  def set_property
    @property = if authorized_user.can_admin_system?
      Property.find(params[:property_id])
    else
      current_user.properties.find(params[:property_id])
    end
  end

  def authorize_view!
    render_forbidden unless authorized_user.can_view_comments?
  end
end
