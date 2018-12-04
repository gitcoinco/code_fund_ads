class PropertyEarningsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property

  private

  def set_property
    @property = Property.find(params[:property_id])
  end
end
