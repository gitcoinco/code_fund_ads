class ImpressionsController < ApplicationController
  include Untrackable

  before_action :set_virtual_impression
  before_action :set_cors_headers
  after_action :create_impression

  def show
    send_file Rails.root.join("app/javascript/images/pixel.gif"), type: "image/gif", disposition: "inline"
  end

  protected

  def sample_requests_for_scout
    sample_rate = (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    if rand > sample_rate
      Rails.logger.debug("[Scout] Ignoring request: #{request.original_url}")
      ScoutApm::Transaction.ignore!
    end
  end

  private

  def set_virtual_impression
    @virtual_impression_id = params[:id]
    @virtual_impression = Rails.cache.read(@virtual_impression_id)
    Rails.cache.delete params[:id]

    if @virtual_impression.nil?
      send_file(Rails.root.join("app/javascript/images/pixel.gif"), type: "image/gif", disposition: "inline", status: :accepted)
    end
  end

  def create_impression
    CreateImpressionJob.perform_later(
      @virtual_impression_id,
      @virtual_impression[:campaign_id],
      @virtual_impression[:property_id],
      @virtual_impression[:creative_id],
      @virtual_impression[:ad_template],
      @virtual_impression[:ad_theme],
      @virtual_impression[:ip_address],
      @virtual_impression[:country_code],
      request.user_agent.encode(Encoding::UTF_8, invalid: :replace, undef: :replace, replace: ""),
      Time.current.iso8601
    )
  end
end
