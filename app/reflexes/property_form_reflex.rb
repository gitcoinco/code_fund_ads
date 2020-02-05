class PropertyFormReflex < ApplicationReflex
  def update_keywords(audience_id)
    @audience = Audience.find_by(id: audience_id)
  end
end
