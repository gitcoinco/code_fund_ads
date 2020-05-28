class EmailsReflex < ApplicationReflex
  def mark_read
    # email.mark_as_read! for: current_user
  end

  def mark_unread
    # The unread gem does not have a built-in way to remove reads on an email
    # By finding the read marks for the current user and destroying the the record
    # we can create this ability ourselves.
    # email.read_marks.find_by(reader: current_user).destroy!
  end

  def toggle_date_format
    session[:email_date_format] = element.dataset["date-format"] == "default" ? "human" : "default"
  end

  private

  def email
    @email ||= Email.find_by(id: element.dataset["email-id"])
  end
end
