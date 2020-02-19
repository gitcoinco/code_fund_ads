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

require "test_helper"

class RegionTest < ActiveSupport::TestCase
end
