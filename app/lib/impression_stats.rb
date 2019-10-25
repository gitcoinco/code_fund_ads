module ImpressionStats
  class << self
    def count(start_date = nil, end_date = nil)
      start_date = Date.coerce(start_date || 365.days.ago.to_date, max: Date.current)
      end_date = Date.coerce(end_date || Date.current, max: Date.current)
      include_today = Date.current.between?(start_date, end_date)
      Rails.cache.fetch "ImpressionStats#count/#{start_date.iso8601}/#{end_date.iso8601}", expires_in: include_today ? 5.seconds : 1.day do
        ActiveRecord::Base.connected_to(role: :reading) do
          count = DailySummary.where(impressionable_type: "Property").scoped_by(nil).between(start_date, end_date).sum(:impressions_count)
          count += Impression.on(Date.current).count if include_today
          count
        end
      end
    end

    def clicks_count(start_date = nil, end_date = nil)
      start_date = Date.coerce(start_date || 365.days.ago.to_date, max: Date.current)
      end_date = Date.coerce(end_date || Date.current, max: Date.current)
      include_today = Date.current.between?(start_date, end_date)
      Rails.cache.fetch "ImpressionsStats#clicks_count/#{start_date.iso8601}/#{end_date.iso8601}", expires_in: include_today ? 5.seconds : 1.day do
        ActiveRecord::Base.connected_to(role: :reading) do
          count = DailySummary.where(impressionable_type: "Property").scoped_by(nil).between(start_date, end_date).sum(:clicks_count)
          count += Impression.on(Date.current).clicked.count if include_today
          count
        end
      end
    end

    def click_rate(start_date = nil, end_date = nil)
      impressions = count(start_date, end_date)
      return 0 unless impressions > 0
      ((clicks_count(start_date, end_date) / impressions.to_f) * 100).round 2
    end

    def property_revenue(start_date = nil, end_date = nil)
      start_date = Date.coerce(start_date || 365.days.ago.to_date, max: Date.current)
      end_date = Date.coerce(end_date || Date.current, max: Date.current)
      include_today = Date.current.between?(start_date, end_date)
      Rails.cache.fetch "ImpressionStats#property_earnings/#{start_date.iso8601}/#{end_date.iso8601}", expires_in: include_today ? 5.seconds : 1.day do
        amount = DailySummary.where(impressionable_type: "Property").scoped_by(nil).between(start_date, end_date).sum(:property_revenue_cents)
        amount += Impression.on(Date.current).sum(:estimated_property_revenue_fractional_cents) if include_today
        Money.new(amount, "USD")
      end
    end
  end
end
