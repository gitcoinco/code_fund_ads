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

    if @virtual_impression.nil?
      instrument "find_virtual_impression.codefund", statsd_key: "web.find_virtual_impression.fail.not_found"
      return head(:not_found)
    end

    if @virtual_impression[:ip_address] != request.remote_ip
      instrument "find_virtual_impression.codefund",
        statsd_key: "web.find_virtual_impression.fail.ip_mismatch.#{@virtual_impression[:campaign_id]}.#{@virtual_impression[:property_id]}"
      Rollbar.debug("IP addresses do not match", {
        virtual_impression: @virtual_impression,
        remote_ip: request.remote_ip,
      })
      return head(:not_found)
    end

    instrument "find_virtual_impression.codefund",
      statsd_key: "web.find_virtual_impression.success.#{@virtual_impression[:campaign_id]}.#{@virtual_impression[:property_id]}"
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
      params[:uplift]
    )
  end
end
