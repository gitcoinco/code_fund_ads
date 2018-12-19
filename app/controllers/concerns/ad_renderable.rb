module AdRenderable
  extend ActiveSupport::Concern

  protected

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
    @theme_mmtime ||= File.mtime(theme_path)
  end

  def theme_cache_key
    @theme_cache_key ||= "themes/#{theme_name}/#{theme_mtime.to_i}"
  end

  def theme
    render_to_string template: "ad_templates/#{template_name}/themes/#{theme_name}.css", layout: false
  end
end
