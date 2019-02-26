module ImpressionsHelper
  def click_rate(impressions_relation)
    return 0.0 unless impressions_relation.count > 0
    (impressions_relation.clicked.count / impressions_relation.count.to_f) * 100
  end
end
