class EmailsReflex < ApplicationReflex
  def mark_read
    email.mark_read_for_user! current_user
  end

  def mark_unread
    email.mark_unread_for_user! current_user
  end

  def toggle_date_format
    session[:email_date_format] = element.dataset["date-format"] == "default" ? "human" : "default"
  end

  private

  def email
    @email ||= Email.find_by(id: element.dataset["email-id"])
  end
end
