class PropertyFormReflex < ApplicationReflex
  include Properties::Stashable

  def update_audience
    if persisted_property
      persisted_property.update audience_id: audience_id
    else
      new_property.assign_attributes audience_id: audience_id
      new_property.assign_keywords
      stash_property(new_property)
    end
  end

  private

  def audience_id
    element[:value].to_i
  end

  def new_property
    @new_property ||= stashed_property
  end

  def persisted_property
    @persisted_property ||= Property.find_by id: element.dataset["property-id"].to_i
  end
end
