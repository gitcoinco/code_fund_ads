class Current < ActiveSupport::CurrentAttributes
  attribute :organization

  resets { Time.zone = nil }

  def organization=(organization)
    super
  end
end
