class EmailComponent < ApplicationComponent
  def initialize(email: nil)
    @email = email
  end

  private

  attr_reader :email

  def render?
    email.present?
  end

  def sender_is_user?
    email.sending_user.present?
  end
end
