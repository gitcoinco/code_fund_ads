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

if advertiser.images.metadata_name("CodeFund Small").metadata_format(ENUMS::IMAGE_FORMATS::SMALL).count == 0
  advertiser.images.attach io: File.open(Rails.root.join("app/assets/images/seeds/code-fund-100x100.png")),
    filename: "code-fund-100x100.png",
    content_type: "image/png",
    metadata: {
      identified: true,
      width: 100,
      height: 100,
      analyzed: true,
      name: "CodeFund Small",
      format: ENUMS::IMAGE_FORMATS::SMALL,
    }
end

if advertiser.images.metadata_name("CodeFund Large").metadata_format(ENUMS::IMAGE_FORMATS::LARGE).count == 0
  advertiser.images.attach io: File.open(Rails.root.join("app/assets/images/seeds/code-fund-260x200.png")),
    filename: "code-fund-100x100.png",
    content_type: "image/png",
    metadata: {
      identified: true,
      width: 260,
      height: 200,
      analyzed: true,
      name: "CodeFund Large",
      format: ENUMS::IMAGE_FORMATS::LARGE,
    }
end

if advertiser.creatives.count == 0
  5.times do
    creative = Creative.create(
      user: advertiser,
      name: Faker::SiliconValley.company,
      headline: Faker::SiliconValley.invention,
      body: Faker::SiliconValley.motto,
    )
    advertiser.images.each do |image|
      CreativeImage.create creative: creative, image: image
    end
  end
end
