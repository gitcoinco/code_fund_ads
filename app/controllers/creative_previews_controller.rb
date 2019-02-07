class CreativePreviewsController < ApplicationController
  include AdRenderable

  before_action :authenticate_user!

  def show
    @creative = if authorized_user.can_admin_system?
      Creative.find(params[:creative_id])
    else
      current_user.creatives.find(params[:creative_id])
    end
    @campaign = Campaign.new(creative: @creative)

    return render_not_found unless template_name && theme_name

    @template_name = template_name
    @theme_name = theme_name

    @preview_html = Premailer.new(
      template,
      with_html_string: true,
      html_fragment: true,
      css_string: theme,
      output_encoding: "utf-8",
      adapter: :nokogiri_fast
    ).to_inline_css.squish

    return render html: @preview_html.html_safe if params[:html_only].present?

    render layout: false
  end

  protected

  def template_name
    ENUMS::AD_TEMPLATES[params[:template]] ? params[:template] : nil
  end

  def theme_name
    ENUMS::AD_THEMES[params[:theme]] ? params[:theme] : nil
  end
end
