class PropertyFormReflex < ApplicationReflex
  include Properties::Stashable

  def update_audience
    property.assign_attributes audience_id: element[:value].to_i
    property.assign_keywords force_audience_keywords: true
  end

  private

  def property
    @property ||= stashed_property
  end
end
