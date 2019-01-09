class ImpressionsController < ApplicationController
  before_action :set_virtual_impression
  after_action :create_impression

  def show
    send_file Rails.root.join("app/assets/images/pixel.gif"), type: "image/gif", disposition: "inline"
  end

  private

  def set_virtual_impression
    @virtual_impression_id = params[:id]
    @virtual_impression = Rails.cache.read(@virtual_impression_id)
    Rails.cache.delete params[:id]

    if @virtual_impression && @virtual_impression[:ip_address] != request.remote_ip
      statsd_increment(["web", "ImpressionsController", "set_virtual_impression", "mismatch"].join("."))
      Raven.capture_message("IP addresses do not match", {
        level: "debug",
        extra: {
          virtual_impression: @virtual_impression,
          remote_ip: request.remote_ip,
        },
      })
    end

    if @virtual_impression.nil? || @virtual_impression[:ip_address] != request.remote_ip
      statsd_increment(["web", "ImpressionsController", "set_virtual_impression", "not_found"].join("."))
      head(:not_found)
    end
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
      Time.current.iso8601
    )
  end
end
