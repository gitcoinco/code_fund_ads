# frozen_string_literal: true

class PropertyScreenshotsController < ApplicationController
  before_action :authenticate_user!

  def update
    property = Property.find(params[:property_id])
    GeneratePropertyScreenshotJob.perform_later(property.id)
    redirect_to property, notice: "Screenshot is being re-captured"
  end
end
