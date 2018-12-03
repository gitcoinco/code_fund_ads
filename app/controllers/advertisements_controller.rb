class AdvertisementsController < ApplicationController
  after_action :create_impression

  def show
    @property_updated_at = Property.where(id: params[:property_id]).maximum(:updated_at)

    # TODO: smarter campaign selection
    @campaign = Campaign.active.available_on(Date.current).for_property_id(params[:property_id]).limit(1).first
    @campaign ||= Campaign.active.available_on(Date.current).fallback_for_property_id(params[:property_id]).limit(1).first

    # TODO: handle missing campaign (i.e. none available)

    @template, @theme = fetch_template_and_theme
  end

  private

  def fetch_template_and_theme
    cache_key = "impressions/#{params[:property_id]}/#{request.remote_ip}"
    template_name = params[:template] || "default"
    theme_name = params[:theme] || "light"
    payload = Rails.cache.fetch(cache_key, expires_in: 10.seconds) {
      @new_impression = true
      {
        template: render_to_string(template: "/ads/#{template_name}/show.html.erb", layout: false),
        theme: render_to_string(template: "/ads/#{template_name}/themes/#{theme_name}.scss.erb", layout: false),
      }
    }
    [payload[:template], payload[:theme]]
  end

  def create_impression
    return unless @new_impression
    CreateImpressionJob.perform_later(
      @campaign.id,
      params[:property_id],
      request.remote_ip,
      request.user_agent,
      Time.current.iso8601
    )
  end
end
