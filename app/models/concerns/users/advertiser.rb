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

    def icon_images(wrapped = false)
      list = images.metadata_format(ENUMS::IMAGE_FORMATS::ICON)
      return list unless wrapped
      list.map { |i| Image.new(i) }
    end

    def small_images(wrapped = false)
      list = images.metadata_format(ENUMS::IMAGE_FORMATS::SMALL)
      return list unless wrapped
      list.map { |i| Image.new(i) }
    end

    def large_images(wrapped = false)
      list = images.metadata_format(ENUMS::IMAGE_FORMATS::LARGE)
      return list unless wrapped
      list.map { |i| Image.new(i) }
    end

    def wide_images(wrapped = false)
      list = images.metadata_format(ENUMS::IMAGE_FORMATS::WIDE)
      return list unless wrapped
      list.map { |i| Image.new(i) }
    end

    def sponsor_images(wrapped = false)
      list = images.metadata_format(ENUMS::IMAGE_FORMATS::SPONSOR)
      return list unless wrapped
      list.map { |i| Image.new(i) }
    end

    def impressions_count_as_advertiser(start_date = nil, end_date = nil)
      return 0 unless advertiser?
      campaigns.map { |c| c.impressions_count(start_date, end_date) }.sum
    end

    def clicks_count_as_advertiser(start_date = nil, end_date = nil)
      return 0 unless advertiser?
      campaigns.map { |c| c.clicks_count(start_date, end_date) }.sum
    end

    def click_rate_as_advertiser(start_date = nil, end_date = nil)
      impressions_count = impressions_count_as_advertiser(start_date, end_date)
      return 0 if impressions_count.zero?
      clicks_count = clicks_count_as_advertiser(start_date, end_date)
      (clicks_count / impressions_count.to_f) * 100
    end
  end
end
