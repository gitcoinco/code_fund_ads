class PixelConversionsController < ApplicationController
  include Untrackable

  skip_before_action :verify_authenticity_token
  before_action :set_cors_headers
  before_action :set_no_caching_headers

  def create
    CreatePixelConversionJob.perform_later pixel_conversion_params.to_h
    head :accepted
  end

  private

  def pixel_conversion_params
    params.permit(:pixel_id, :impression_id, :test, :metadata).tap do |whitelisted|
      whitelisted[:conversion_referrer] = request.referrer
      whitelisted[:test] = whitelisted[:test].to_s.downcase == "true"
      whitelisted[:metadata] = JSON.parse(whitelisted[:metadata]) if whitelisted[:metadata].present?
    end
  end
end
