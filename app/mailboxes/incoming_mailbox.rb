class IncomingMailbox < ApplicationMailbox
  #before_processing :ensure_sender_is_a_user

  def process
    Rails.logger.debug("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    Rails.logger.debug("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    Rails.logger.debug("~~~~~~~~~~~~~~~~~~~        INCOMING           ~~~~~~~~~~~~~~~~~~~~")
    Rails.logger.debug("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    Rails.logger.debug("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
  end

  private

  def ensure_sender_is_a_user
    # unless User.exist?(email: mail.from)
    # bounce_with UserRequireMailer.missing(mail)
    # end
  end
end
