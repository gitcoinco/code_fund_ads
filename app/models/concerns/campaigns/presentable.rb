# frozen_string_literal: true

module Campaigns
  module Presentable
    extend ActiveSupport::Concern

    def scoped_name
      [user.scoped_name, name, creative&.name].compact.join "・"
    end

    def daily_spend_series(days = 30)
      # Calculate spend for x days by day
      # TODO: Use roll-up data
      [[10, 8, 5, 7, 6, 6, 10, 10, 8, 5, 7, 6, 6, 10, 6, 6, 10, 10, 8, 5, 7, 6, 6, 10, 6, 6, 10, 10, 8]]
    end
  end
end
