module Properties
  module Presentable
    extend ActiveSupport::Concern

    def scoped_name
      [user&.name, name].compact.join "・"
    end

    def analytics_key
      [id, name].compact.join ": "
    end

    alias to_s analytics_key

    def display_url
      url.gsub(/https?:\/\//, "")
    end
  end
end
