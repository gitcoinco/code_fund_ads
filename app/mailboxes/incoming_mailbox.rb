class IncomingMailbox < ApplicationMailbox
  before_processing :ensure_sender_is_a_user

  def process
    # Creating the feedback
    # mail.decoded returns the email body if mail is not multipart 
    # else we'll use mail.parts[0].body.decoded
    # and in our case that is feedback
    #if mail.parts.present?
      #Feedback.create user_id: @user.id, product_id: product_id, content: mail.parts[0].body.decoded
    #else
      #Feedback.create user_id: @user.id, product_id: product_id, content: mail.decoded
    #end
    puts "PROCESSING!"
    binding.pry
    # email = Email.new
    # email.message_id = 
    # email.content = 
    # email.delivered_at = 
    # email.from =
    # email.to = 
    # email.subject =
    # email.save
  end

  private

  def ensure_sender_is_a_user
    # unless User.exist?(email: mail.from)
    # bounce_with UserRequireMailer.missing(mail)
    # end
  end
end
