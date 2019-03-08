class ImpressionsController < ApplicationController
  before_action :set_virtual_impression
  before_action :set_cors_headers
  after_action :create_impression

  def show
    send_file Rails.root.join("app/assets/images/pixel.gif"), type: "image/gif", disposition: "inline"
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
      track_event({status: "not_found"})
      return head(:not_found)
    end

    track_event({
      status: "success",
      campaign_id: @virtual_impression[:campaign_id],
      property_id: @virtual_impression[:property_id],
    })
  end

  def create_impression
    CreateImpressionJob.perform_later(
      @virtual_impression_id,
      @virtual_impression[:campaign_id],
      @virtual_impression[:property_id],
      params[:template],
      params[:theme],
      request.remote_ip,
      request.user_agent,
      Time.current.iso8601,
    )
  end

  def track_event(data)
    CodeFundAds::Events.track("Find Virtual Impression", @virtual_impression_id, {ip_address: request.remote_ip}.merge(data))
  end
end
