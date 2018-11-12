# frozen_string_literal: true

module Users
  module Presentable
    extend ActiveSupport::Concern

    def full_name
      [first_name, last_name].compact.join " "
    end

    alias_method :name, :full_name

    def scoped_name
      [company_name, full_name].compact.join "・"
    end

    def gravatar_url
      require "digest/md5"
      hash = Digest::MD5.hexdigest(email)
      "https://www.gravatar.com/avatar/#{hash}"
    end
  end
end
