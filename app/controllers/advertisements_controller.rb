class AdvertisementsController < ApplicationController
  after_action :create_impression

  # TODO: perfomance tuning
  def show
    @property = Property.find(params[:property_id])

    # TODO: make campaign selection more intelligent
    @campaign = Campaign.find_by(id: property.matching_campaigns.avaliable_on(Date.current).pluck(:id).sample)

    # TODO: handle missing campaign (i.e. fallback)

    template_name = params[:template] || "default"
    theme_name = parmas[:theme] || "light"

    cache_key = "impressions/#{property.id}/#{request.remote_ip}"
    @payload = Rails.cache.fetch(cache_key, expires_in: 10.seconds) {
      @new_impression = true
      {
        template: render_to_string(template: "/ads/#{template_name}/show"),
        theme: render_to_string(template: "/ads/#{template_name}/themes/#{theme_name}"),
      }
    }
  end

  private

  def create_impression
    return unless @new_impression
    CreateImpressionJob.perform_later(
      @property,
      @campaign,
      request.remote_ip,
      request.user_agent,
      Time.current.iso8601
    )
  end
end
