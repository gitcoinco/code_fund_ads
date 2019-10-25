module HomeHelper
  def butter_render(content, params = {})
    Mustache.render(content, params).html_safe
  end
end
