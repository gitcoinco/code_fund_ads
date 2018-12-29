# Preview all emails at http://localhost:3000/rails/mailers/applicant_mailer
class DeviseMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user = User.new(email: "example@codefund.io", first_name: "Joe", roles: ["publisher"])
    DeviseMailer.confirmation_instructions(user, SecureRandom.uuid)
  end

  def reset_password_instructions
    user = User.new(email: "example@codefund.io", first_name: "Joe", roles: ["publisher"])
    DeviseMailer.reset_password_instructions(user, SecureRandom.uuid)
  end

  def unlock_instructions
    user = User.new(email: "example@codefund.io", first_name: "Joe", roles: ["publisher"])
    DeviseMailer.unlock_instructions(user, SecureRandom.uuid)
  end

  def email_changed
    user = User.new(email: "example@codefund.io", first_name: "Joe", roles: ["publisher"])
    DeviseMailer.email_changed(user)
  end

  def password_change
    user = User.new(email: "example@codefund.io", first_name: "Joe", roles: ["publisher"])
    DeviseMailer.password_change(user)
  end

  def publisher_invitation_instructions
    user = User.new(
      email: "example@codefund.io",
      first_name: "Joe",
      invitation_token: SecureRandom.uuid,
      invitation_created_at: Time.current,
      invitation_limit: 0,
      invited_by_type: "User",
      invited_by_id: 1,
      roles: ["publisher"]
    )
    DeviseMailer.invitation_instructions(user, SecureRandom.uuid)
  end

  def advertiser_invitation_instructions
    user = User.new(
      email: "example@codefund.io",
      first_name: "Joe",
      invitation_token: SecureRandom.uuid,
      invitation_created_at: Time.current,
      invitation_limit: 0,
      invited_by_type: "User",
      invited_by_id: 1,
      roles: ["advertiser"]
    )
    DeviseMailer.invitation_instructions(user, SecureRandom.uuid)
  end
end
