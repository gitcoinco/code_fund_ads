# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_changed
  def password_changed
    UserMailer.password_changed("chris.knight@codefund.io")
  end
end
