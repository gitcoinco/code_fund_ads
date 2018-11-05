# frozen_string_literal: true

require "faker"

unless Rails.env.development?
  puts "SEEDS ARE FOR DEVELOPMENT ONLY!"
  exit 1
end

user_attributes = {
  company_name: "CodeFund",
  confirmation_sent_at: 2.days.ago,
  confirmed_at: 1.day.ago,
  password: "secret",
  password_confirmation: "secret",
}

administrator = User.find_or_initialize_by(email: "chris.knight@codefund.io")
administrator.assign_attributes(
  user_attributes.merge(
    roles: [ENUMS::USER_ROLES::ADMINISTRATOR],
    first_name: "Chris",
    last_name: "Knight",
  ))
administrator.save!

publisher = User.find_or_initialize_by(email: "mitch.taylor@codefund.io")
publisher.assign_attributes(
  user_attributes.merge(
    roles: [ENUMS::USER_ROLES::PUBLISHER],
    first_name: "Mitch",
    last_name: "Taylor",
  ))
publisher.save!

advertiser = User.find_or_initialize_by(email: "jordan.cochran@codefund.io")
advertiser.assign_attributes(
  user_attributes.merge(
    roles: [ENUMS::USER_ROLES::ADVERTISER],
    first_name: "Jordan",
    last_name: "Cochran",
  ))
advertiser.save!
