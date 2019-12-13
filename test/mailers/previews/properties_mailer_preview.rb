class PropertiesMailerPreview < ActionMailer::Preview
  def new_property_email
    PropertiesMailer.new_property_email(Property.last)
  end
end
