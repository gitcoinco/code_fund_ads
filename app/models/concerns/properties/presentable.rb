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

    def excluded_company_names
      User.advertisers.where(id: prohibited_advertiser_ids).pluck(:company_name).select(&:present?).uniq.sort
    end
  end
end
