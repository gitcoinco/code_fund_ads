class OrganizationCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_view!, only: :index
  before_action :set_organization, only: :index

  def index
    @comments = @organization.comment_threads
  end

  private

  def set_organization
    @organization = Current.organization
  end

  def authorize_view!
    render_forbidden unless authorized_user.can_view_comments?
  end
end
