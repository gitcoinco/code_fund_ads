class ImpersonationsController < ApplicationController
  before_action :authenticate_administrator!, only: [:update]
  before_action :reset_searches

  def update
    user = User.find(params[:user_id])
    impersonate_user(user)
    redirect_to user_path(user)
  end

  def destroy
    stop_impersonating_user
    redirect_to users_path
  end

  private

  def reset_searches
    session[:user_search] = UserSearch.new.to_gid_param
    session[:campaign_search] = CampaignSearch.new.to_gid_param
    session[:creative_search] = CreativeSearch.new.to_gid_param
    session[:image_search] = ImageSearch.new.to_gid_param
    session[:job_posting_search] = JobPostingSearch.new.to_gid_param
    session[:organization_search] = OrganizationSearch.new.to_gid_param
    session[:property_search] = PropertySearch.new.to_gid_param
  end
end
