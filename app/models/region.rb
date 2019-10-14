# == Schema Information
#
# Table name: regions
#
#  id                                        :integer          primary key
#  name                                      :text
#  blockchain_ecpm_currency                  :text
#  blockchain_ecpm_cents                     :integer
#  css_and_design_ecpm_currency              :text
#  css_and_design_ecpm_cents                 :integer
#  dev_ops_ecpm_currency                     :text
#  dev_ops_ecpm_cents                        :integer
#  game_development_ecpm_currency            :text
#  game_development_ecpm_cents               :integer
#  javascript_and_frontend_ecpm_currency     :text
#  javascript_and_frontend_ecpm_cents        :integer
#  miscellaneous_ecpm_currency               :text
#  miscellaneous_ecpm_cents                  :integer
#  mobile_development_ecpm_currency          :text
#  mobile_development_ecpm_cents             :integer
#  web_development_and_backend_ecpm_currency :text
#  web_development_and_backend_ecpm_cents    :integer
#  country_codes                             :text             is an Array
#

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
    public_send audience.ecpm_column_name.delete_suffix("_cents")
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
