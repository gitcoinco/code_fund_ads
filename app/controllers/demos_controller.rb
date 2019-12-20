class DemosController < ApplicationController
  protect_from_forgery unless: -> { request.format.js? }
  before_action :set_cors_headers
  before_action :set_no_caching_headers
  layout "demo"

  helper_method :template_name, :theme_name

  def index
    # binding.pry
    @ad_url = advertisement_preview_path(campaign_id, template: template, theme: theme, format: :js)
    # @ad_url = "#{base_url}?template=#{template}&theme=#{theme}"
    # binding.pry
    # render "/advertisements/show", property_id: ENV["PROPERTY_DEMO_ID"], template: template, theme: theme, ad_test: true
  end

  def template
    @template ||= "default"
  end

  def theme
    @theme ||= "light"
  end

  def campaign_id
    @campaign_id = 395
  end

  private

  def base_url
    "http://localhost:3000/properties/#{ENV["PROPERTY_DEMO_ID"]}/funder.js"
  end
end
