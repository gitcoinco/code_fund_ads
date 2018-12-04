class ImpressionsController < ApplicationController
  before_action :set_virtual_impression
  after_action :create_impression

  private

  def set_virtual_impression
    @virtual_impression = Rails.cache.read(params[:id])
    Rails.cache.delete params[:id]
    head(:not_found) if @virtual_impression.nil? || @virtual_impression[:ip_address] != request.remote_ip
  end

  def create_impression
    CreateImpressionJob.perform_later(
      @virtual_impression[:campaign_id],
      @virtual_impression[:property_id],
      request.remote_ip,
      request.user_agent,
      Time.current.iso8601
    )
  end
end
