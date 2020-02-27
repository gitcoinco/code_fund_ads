class Current < ActiveSupport::CurrentAttributes
  attribute :organization, :user_interface

  def user_interface?
    !!user_interface
  end
end
