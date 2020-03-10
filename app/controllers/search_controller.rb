class SearchController < ApplicationController
  before_action :authenticate_administrator!

  def show
    return handle_redirect if params[:sgid].present?

    q = params[:q].strip.downcase
    @results = {
      users: User.search_name(q).or(User.search_email(q)).order(created_at: :desc).limit(5),
      properties: Property.search_name(q).order(created_at: :desc).limit(5),
      campaigns: Campaign.search_name(q).order(created_at: :desc).limit(5),
      organizations: Organization.search_name(q).order(created_at: :desc).limit(5)
    }
    render layout: false
  end

  def handle_redirect
    obj = GlobalID.parse(params[:sgid]).find
    redirect_to obj
  end
end
