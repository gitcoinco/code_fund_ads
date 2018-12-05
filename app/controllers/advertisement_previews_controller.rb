class AdvertisementPreviewsController < ApplicationController
  layout false
  before_action :set_property

  private

  def set_property
    @property = Property.find(params[:property_id])
  end
end
