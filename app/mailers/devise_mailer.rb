class DeviseMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: "devise/mailer"
  default from: "team@codefund.io"
  layout "mailer"

  before_action :set_inline_attachments

  protected

  def set_inline_attachments
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/codefund-logo.png")
  end
end
