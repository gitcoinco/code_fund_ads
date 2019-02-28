module AdRenderable
  extend ActiveSupport::Concern

  protected

  def render_advertisement_html(template, theme, html: false)
    formatted_code = Premailer.new(
      template,
      with_html_string: true,
      html_fragment: true,
      css_string: theme,
      output_encoding: "utf-8",
      adapter: :nokogiri_fast
    ).to_inline_css.squish
    formatted_code = formatted_code.gsub(/\'/, "&quot;") unless html
    formatted_code
  end

  # Ad Template ----------------------------------------------------------------------------------------------

  def template_name
    raise NotImplementedError, "Must be implemented by classes that include this module"
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

  # Ad Theme -------------------------------------------------------------------------------------------------

  def theme_name
    raise NotImplementedError, "Must be implemented by classes that include this module"
  end

  def theme_path
    @theme_path ||= Rails.root.join("app/views/ad_templates/#{template_name}/themes/#{theme_name}.css")
  end

  def theme_mtime
    return Time.at(1546300800) if theme_name == ENUMS::AD_THEMES::UNSTYLED # 2019-01-01 00:00:00 UTC
    @theme_mmtime ||= File.mtime(theme_path)
  end

  def theme_cache_key
    @theme_cache_key ||= "themes/#{theme_name}/#{theme_mtime.to_i}"
  end

  def theme
    return "" if theme_name == ENUMS::AD_THEMES::UNSTYLED
    render_to_string template: "ad_templates/#{template_name}/themes/#{theme_name}.css", layout: false
  end
end
