class AdvertisementsController < ApplicationController
  protect_from_forgery except: :show
  before_action :set_template_and_theme

  def show
    # TODO: smarter campaign selection
    @campaign = Campaign.active.available_on(Date.current).for_property_id(params[:property_id]).limit(1).first
    @campaign ||= Campaign.active.available_on(Date.current).fallback_for_property_id(params[:property_id]).limit(1).first

    @advertisement_html = render_advertisement if @campaign
  end

  private

  attr_reader :template_name, :theme_name

  def set_template_and_theme
    @template_name = params[:template]
    @theme_name = params[:theme]

    unless @template_name && @theme_name
      template_name, theme_name = Property.where(id: params[:property_id]).pluck(:ad_template, :ad_theme).first
      @template_name ||= template_name
      @theme_name ||= theme_name
    end

    @template_name ||= "default"
    @theme_name ||= "light"
  end

  def template_path
    @template_path ||= Rails.root.join("app/views/ad_templates/#{template_name}/show.html.erb")
  end

  def template_mtime
    @template_mtime ||= File.mtime(template_path)
  end

  def template_cache_key
    @template_cache_key ||= "templates/#{template_name}/#{template_mtime.to_i}"
  end

  def template
    render_to_string template: "/ad_templates/#{template_name}/show.html.erb", layout: false
  end

  def theme_path
    @theme_path ||= Rails.root.join("app/views/ad_templates/#{template_name}/themes/#{theme_name}.css")
  end

  def theme_mtime
    @theme_mmtime ||= File.mtime(theme_path)
  end

  def theme_cache_key
    @theme_cache_key ||= "themes/#{theme_name}/#{theme_mtime.to_i}"
  end

  def theme
    Rails.cache.fetch(theme_cache_key) do
      render_to_string template: "ad_templates/#{template_name}/themes/#{theme_name}.css", layout: false
    end
  end

  def ad_cache_key
    @themed_template_cache_key ||= "#{template_cache_key}/#{theme_cache_key}/#{@campaign.cache_key}"
  end

  def render_advertisement
    Rails.cache.fetch(ad_cache_key) do
      Premailer.new(
        template,
        with_html_string: true,
        html_fragment: true,
        css_string: theme,
        output_encoding: "utf-8",
        adapter: :nokogiri_fast
      ).to_inline_css.strip.gsub(/\s\s|\n/, "")
    end
  end

  # def visitor_ad_cache_key
  #   "ad/#{params[:property_id]}/#{request.remote_ip}"
  # end

  # TODO: move this to pixel fire endpoint
  # def create_impression
  #  CreateImpressionJob.perform_later(
  #    @campaign.id,
  #    params[:property_id],
  #    request.remote_ip,
  #    request.user_agent,
  #    Time.current.iso8601
  #  )
  # end
end
