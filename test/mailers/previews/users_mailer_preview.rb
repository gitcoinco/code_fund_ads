class UsersMailerPreview < ActionMailer::Preview
  def new_consolidated_screening_list_flag_email
    UsersMailer.new_consolidated_screening_list_flag_email(User.last)
  end
end
