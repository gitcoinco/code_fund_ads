module PropertiesHelper
  def properties_for_select
    Property.active.or(Property.pending).order(Property.arel_table[:name].lower).map { |p| [p.name, p.id] }
  end

  def property_types_for_select
    ENUMS::PROPERTY_TYPES.values.map { |val| [val.humanize, val] }
  end

  def property_statuses_for_select
    ENUMS::PROPERTY_STATUSES.values.map { |val| [val.humanize, val] }
  end

  def property_status_color(status)
    ENUMS::PROPERTY_STATUS_COLORS[status]
  end

  def property_responsive_behaviors_for_select
    [
      ["Show ad using the configured template and theme", ENUMS::PROPERTY_RESPONSIVE_BEHAVIORS::NONE],
      ["Show ad using a sticky footer that can be closed by the user", ENUMS::PROPERTY_RESPONSIVE_BEHAVIORS::FOOTER],
      ["Do not show ads", ENUMS::PROPERTY_RESPONSIVE_BEHAVIORS::HIDE],
    ]
  end

  def property_status_title(status)
    return status.humanize unless status.inquiry.pending?

    "Awaiting Administrator Approval"
  end
end
