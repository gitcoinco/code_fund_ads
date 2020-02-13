module CreativesHelper
  def creative_statuses_for_select
    ENUMS::CREATIVE_STATUSES.values.map { |val| [val.humanize, val] }
  end

  def creative_status_color(status)
    ENUMS::CREATIVE_STATUS_COLORS[status]
  end
end
