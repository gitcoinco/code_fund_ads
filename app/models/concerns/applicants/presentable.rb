module Applicants
  module Presentable
    extend ActiveSupport::Concern

    def scoped_name
      [company_name, full_name].compact.join "・"
    end

    def full_name
      [first_name, last_name].compact.join " "
    end

    alias name full_name

    def hashed_email
      Digest::MD5.hexdigest(email.downcase)
    end

    def gravatar_url(d = "404")
      "https://www.gravatar.com/avatar/#{hashed_email}"
    end
  end
end
