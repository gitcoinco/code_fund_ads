class AdvertisementsController < ApplicationController
  after_action :create_impression

  # TODO: performance tuning
  def show
    @property = Property.find(params[:property_id])
    @campaign = @property.matching_campaigns.available_on(Date.current).sample
    @campaign ||= Campaign.where(fallback: true).sample unless @property.prohibit_fallback_campaigns?

    # TODO: handle missing campaign (i.e. none available)

    template_name = params[:template] || "default"
    theme_name = params[:theme] || "light"

    cache_key = "impressions/#{@property.id}/#{request.remote_ip}"
    @payload = Rails.cache.fetch(cache_key, expires_in: 10.seconds) {
      @new_impression = true
      {
        template: render_to_string(template: "/ads/#{template_name}/show.html.erb"),
        theme: render_to_string(template: "/ads/#{template_name}/themes/#{theme_name}.scss.erb"),
      }
    }
  end

  private

  def create_impression
    return unless @new_impression
    CreateImpressionJob.perform_later(@property, @campaign, request.remote_ip, request.user_agent, Time.current.iso8601)
  end
end
