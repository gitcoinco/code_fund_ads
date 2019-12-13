class Current < ActiveSupport::CurrentAttributes
  attribute :organization

  def organization=(organization)
    super
  end
end
