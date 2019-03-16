module Properties
  module Presentable
    extend ActiveSupport::Concern

    def scoped_name
      [user.scoped_name, name].compact.join "・"
    end

    def display_url
      url.gsub(/https?:\/\//, "")
    end

    def excluded_company_names
      User.advertisers.where(id: prohibited_advertiser_ids).pluck(:company_name).sort
    end
  end
end
