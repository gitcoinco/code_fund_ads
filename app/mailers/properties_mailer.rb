class PropertiesMailer < ApplicationMailer
  default from: "alerts@codefund.io"
  layout "mailer"

  def new_property_email(property)
    @property = property
    mail(
      to: ENUMS::EMAIL_ADDRESSES::JUSTIN,
      cc: ENUMS::EMAIL_ADDRESSES::ERIC,
      bcc: "team@codefund.io",
      from: "alerts@codefund.io",
      subject: "A property has been created",
    )
  end
end
