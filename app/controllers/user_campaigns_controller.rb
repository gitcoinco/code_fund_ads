# frozen_string_literal: true

class UserCampaignsController < ApplicationController
  before_action :set_user
  before_action :set_campaign_search

  def index
    campaigns = @user.campaigns.order(:name).includes(:user, :creative)
    campaigns = @campaign_search.apply(campaigns)
    @pagy, @campaigns = pagy(campaigns)
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_campaign_search
      @campaign_search = CampaignSearch.new
    end
end
