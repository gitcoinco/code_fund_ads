class ApplicationMailer < ActionMailer::Base
  default from: "team@codefund.io"
  layout "mailer"

  before_action :set_inline_attachments

  protected

  def set_inline_attachments
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/javascript/images/branding/codefund-logo.png")
  end
end
