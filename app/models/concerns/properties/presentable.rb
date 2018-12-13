module Properties
  module Presentable
    extend ActiveSupport::Concern

    def scoped_name
      [user.scoped_name, name].compact.join "・"
    end

    def display_url
      url.gsub(/https?:\/\//, "")
    end
  end
end
