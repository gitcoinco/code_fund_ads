class DemosController < ApplicationController
  before_action :load_campaigns

  layout "demo"
  helper_method :position
  ABSOLUTE = ["bottom-bar", "top-bar", "smart-bar", "sticky-box"]

  def show
    @template = demo_params[:template] || "default"
    @theme = demo_params[:theme] || "light"
    @campaign_id = demo_params[:campaign_id] || ENV["CAMPAIGN_DEMO_ID"]
    @script_path = "/ad-previews/#{@campaign_id}.js?template=#{@template}&theme=#{@theme}"
  end

  def update
    redirect_to demo_path(template: params[:template], theme: params[:theme], campaign_id: params[:campaign_id])
  end

  def position
    return "absolute" if ABSOLUTE.include?(@template)

    "relative"
  end

  private

  def campaign
    @campaign ||= Campaign.find(@campaign_id)
  end

  def demo_params
    params.permit(:template, :theme, :campaign_id)
  end

  def load_campaigns
    @campaigns = if authorized_user&.can_admin_system?
      Campaign.all.order(name: :asc)
    elsif current_user&.campaigns
      current_user.campaigns.order(name: :asc)
    else
      []
    end
  end
end
