module Impressionable
  extend ActiveSupport::Concern

  def dates_with_impressions
    impressions.select(:displayed_at_date).distinct.pluck(:displayed_at_date)
  end

  def dates_with_payable_impressions
    impressions.payable.select(:displayed_at_date).distinct.pluck(:displayed_at_date)
  end

  def dates_with_clicked_impressions
    impressions.clicked.select(:displayed_at_date).distinct.pluck(:displayed_at_date)
  end

  def dates_with_clicked_payable_impressions
    impressions.clicked.payable.select(:displayed_at_date).distinct.pluck(:displayed_at_date)
  end
end
