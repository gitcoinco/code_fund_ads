class PropertiesMailer < ApplicationMailer
  default from: "alerts@codefund.io"

  def new_property_email(property)
    @property = property
    mail(
      to: "team@codefund.io",
      from: "alerts@codefund.io",
      subject: "A property has been added by #{@property.user&.name}"
    )
  end

  def impressions_drop_email(properties)
    @properties = properties
    mail(
      to: "team@codefund.io",
      from: "alerts@codefund.io",
      subject: "#{@properties.size} properties with a dramatic drop in impressions"
    )
  end
end
