class WebsitesController < ApplicationController
  def index
    properties = Property.active.order(:name)
    @pagy, @properties = pagy(properties, items: 12)
  end
end
