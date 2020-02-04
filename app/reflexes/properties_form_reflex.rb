class PropertiesFormReflex < ApplicationReflex
  def update_keywords(audience_id)
    audience = Audience.find_by(id: audience_id)
    session[:property_keywords] = audience.keywords
  end
end
