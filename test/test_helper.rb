ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def attach_small_image!(user)
    user.images.attach(
      io: File.open(Rails.root.join("app/assets/images/seeds/code-fund-100x100.png")),
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
    ).first
  end

  def attach_large_image!(user)
    user.images.attach(
      io: File.open(Rails.root.join("app/assets/images/seeds/code-fund-260x200.png")),
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
    ).first
  end
end
