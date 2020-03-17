class PropertiesMailerPreview < ActionMailer::Preview
  def new_property_email
    PropertiesMailer.new_property_email(Property.first)
  end

  def impressions_drop_email
    PropertiesMailer.impressions_drop_email([Property.first])
  end
end
