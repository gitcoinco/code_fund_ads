module Users
  module Presentable
    extend ActiveSupport::Concern

    def full_name
      [first_name, last_name].compact.join " "
    end

    alias name full_name

    def gravatar_url
      require "digest/md5"
      hash = Digest::MD5.hexdigest(email)
      "https://www.gravatar.com/avatar/#{hash}"
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
