module Users
  module Presentable
    extend ActiveSupport::Concern

    def scoped_name
      [default_organization&.name, full_name].compact.join "·"
    end

    def full_name
      [first_name, last_name].compact.join " "
    end

    def initials
      [first_name[0], last_name[0]].compact.join.upcase
    end

    alias name full_name

    def hashed_email
      Digest::MD5.hexdigest(email.downcase)
    end

    def gravatar_url(d = "identicon")
      "https://www.gravatar.com/avatar/#{hashed_email}?s=300&d=#{d}"
    end

    def display_region
      if country == "US"
        [city, region].join(", ")
      else
        [city, country].join(", ")
      end
    end
  end
end
