class AdvertisementsController < ApplicationController
  # TODO: perfomance tuning
  def show
    property = Property.find(params[:property_id])

    # TODO: make campaign selection more intelligent
    campaign = Campaign.find_by(id: property.matching_campaigns.pluck(:id).sample)

    # TODO: handle missing campaign (i.e. fallback)

    template_name = params[:template] || "default"
    theme_name = parmas[:theme] || "light"

    @template = render_to_string(template: "/ads/#{template_name}/show")
    @theme = render_to_string(template: "/ads/#{template_name}/themes/#{theme_name}")
  end
end
