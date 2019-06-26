module Creatives
  module Presentable
    extend ActiveSupport::Concern

    def analytics_key
      [id, name].compact.join ": "
    end

    def sanitized_headline
      sanitize_value headline
    end

    def sanitized_body
      sanitize_value body
    end
  end
end
