class Region < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Taggable

  # relationships .............................................................
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  self.primary_key = :id
  tag_columns :country_codes

  monetize :blockchain_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :css_and_design_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :dev_ops_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :game_development_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :javascript_and_frontend_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :miscellaneous_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :mobile_development_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :web_development_and_backend_ecpm_cents, numericality: {greater_than_or_equal_to: 0}

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def read_only?
    true
  end

  def ecpm(audience)
    public_send "#{audience.key}_ecpm"
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
