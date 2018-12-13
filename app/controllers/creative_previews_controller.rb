class CreativePreviewsController < ApplicationController
  before_action :authenticate_user!

  include AdRenderable

  def show
    @creative = current_user.creatives.find(params[:creative_id])
    @campaign = Campaign.new(creative: @creative)
    @template_name = params[:template] if ENUMS::AD_TEMPLATES.value?(params[:template])
    @theme_name = params[:theme] if ENUMS::AD_THEMES.value?(params[:theme])

    render_not_found unless @template_name && @theme_name

    @preview_html = Premailer.new(
      template,
      with_html_string: true,
      html_fragment: true,
      css_string: theme,
      output_encoding: "utf-8",
      adapter: :nokogiri_fast
    ).to_inline_css.strip.gsub(/\s\s|\n/, "")

    render layout: false
  end
end
