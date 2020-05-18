class Emails::MessageViewerComponent < ApplicationComponent
  def initialize(email: nil, bold: false)
    @email = email
    @bold = bold
  end

  def user
    User.find_by(email: email)
  end

  def classes
    class_names = []
    class_names << "font-weight-bold" if bold
    class_names.compact
  end

  private

  attr_reader :email, :bold

  def render?
    email.present?
  end
end
