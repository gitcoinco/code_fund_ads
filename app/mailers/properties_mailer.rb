class PropertiesMailer < ApplicationMailer
  default from: "alerts@codefund.io"
  layout "mailer"

  def new_property_email(property)
    @property = property
    mail(
      to: "team@codefund.io",
      from: "alerts@codefund.io",
      subject: "A property has been added by #{@property.user&.name}",
    )
  end
end
