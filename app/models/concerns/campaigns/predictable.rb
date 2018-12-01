module Campaigns
  module Predictable
    extend ActiveSupport::Concern

    def estimated_max_total_impression_count
      ((total_budget.to_f / ecpm.to_f) * 1_000).ceil
    end

    def estimated_max_remaining_impression_count
      estimated_max_daily_impression_count * remaining_operative_days
    end

    def estimated_max_daily_impression_count
      ((daily_budget.to_f / ecpm.to_f) * 1_000).ceil
    end
  end
end
