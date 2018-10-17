# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  address_1              :string(255)
#  address_2              :string(255)
#  city                   :string(255)
#  region                 :string(255)
#  postal_code            :string(255)
#  country                :string(255)
#  roles                  :string(255)      is an Array
#  revenue_rate           :decimal(3, 3)    default(0.5), not null
#  password_hash          :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  failed_attempts        :integer          default(0)
#  locked_at              :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  unlock_token           :string(255)
#  remember_created_at    :datetime
#  inserted_at            :datetime         not null
#  updated_at             :datetime         not null
#  paypal_email           :string(255)
#  company                :string(255)
#  api_access             :boolean          default(FALSE), not null
#  api_key                :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
