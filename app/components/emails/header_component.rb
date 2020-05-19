class Emails::HeaderComponent < ApplicationComponent
  def initialize(email: nil)
    @email = email
  end

  def sender
    email.sending_user
  end

  def delivered_at
    email.delivered_at
  end

  private

  attr_reader :email

  def render?
    email.present?
  end
end
