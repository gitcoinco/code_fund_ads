module Users
  module Advertiser
    extend ActiveSupport::Concern

    included do
      has_many :campaigns
      has_many :creatives
    end

    def advertiser?
      roles.include? ENUMS::USER_ROLES::ADVERTISER
    end

    def operational_advertiser?
      return false unless advertiser?
      campaigns.map(&:operational?).include? true
    end
  end
end
