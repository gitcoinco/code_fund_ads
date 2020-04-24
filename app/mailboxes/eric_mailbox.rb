class EricMailbox < ApplicationMailbox
  before_processing :require_user
  after_processing :record_user_ids

  def process
    # Twiddle thumbs
  end

  private

  def require_user
    @user = User.find_by(email: mail.from)
    return bounced! unless @user
  end

  def record_user_ids
    inbound_email.add_metadata!
  end
end
