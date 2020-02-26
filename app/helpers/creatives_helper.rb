module CreativesHelper
  def creative_statuses_for_select
    ENUMS::CREATIVE_STATUSES.values.map { |val| [val.humanize, val] }
  end
end
