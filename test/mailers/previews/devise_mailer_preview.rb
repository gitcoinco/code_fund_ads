# Preview all emails at http://localhost:3000/rails/mailers/applicant_mailer
class DeviseMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user = User.new(email: "example@codefund.io", first_name: "Joe")
    DeviseMailer.confirmation_instructions(user, SecureRandom.uuid)
  end

  def reset_password_instructions
    user = User.new(email: "example@codefund.io", first_name: "Joe")
    DeviseMailer.reset_password_instructions(user, SecureRandom.uuid)
  end

  def unlock_instructions
    user = User.new(email: "example@codefund.io", first_name: "Joe")
    DeviseMailer.unlock_instructions(user, SecureRandom.uuid)
  end

  def email_changed
    user = User.new(email: "example@codefund.io", first_name: "Joe")
    DeviseMailer.email_changed(user)
  end

  def password_change
    user = User.new(email: "example@codefund.io", first_name: "Joe")
    DeviseMailer.password_change(user)
  end

  def invitation_instructions
    user = User.new(
      email: "example@codefund.io",
      first_name: "Joe",
      invitation_token: SecureRandom.uuid,
      invitation_created_at: Time.current,
      invitation_limit: 0,
      invited_by_type: "User",
      invited_by_id: 1
    )
    DeviseMailer.invitation_instructions(user, SecureRandom.uuid)
  end
end
