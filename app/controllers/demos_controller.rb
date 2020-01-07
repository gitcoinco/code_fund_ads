class DemosController < ApplicationController
  layout "demo"
  helper_method :position
  ABSOLUTE = ["bottom-bar", "top-bar", "smart-bar", "sticky-box"]

  def show
    @template = demo_params[:template] || "default"
    @theme = demo_params[:theme] || "light"
    @script_path = "/ad-previews/#{campaign.id}.js?template=#{@template}&theme=#{@theme}"
  end

  def update
    redirect_to demo_path(template: params[:template], theme: params[:theme])
  end

  def position
    return "absolute" if ABSOLUTE.include?(@template)

    "relative"
  end

  private

  def campaign
    @campaign ||= Campaign.find(ENV["CAMPAIGN_DEMO_ID"])
  end

  def demo_params
    params.permit(:template, :theme)
  end
end
