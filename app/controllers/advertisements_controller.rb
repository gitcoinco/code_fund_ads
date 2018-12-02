class AdvertisementsController < ApplicationController
  def show
    property = Property.find(params[:property_id])

    # TODO: make campaign selection more intelligent
    campaign = Campaign.find_by(id: property.matching_campaigns.pluck(:id).sample)

    # TODO: handle missing campaign (i.e. fallback)

    template_name = params[:template] || "default"
    theme_name = parmas[:theme] || "light"

    # TODO: setup instance variables
  end
end
