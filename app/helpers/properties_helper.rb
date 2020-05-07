module PropertiesHelper
  def property_tabs(property)
    [
      {name: "Overview", path: property_path(property), active: :exact},
      {name: "Instructions", path: property_instructions_path(property)},
      {name: "Earnings", path: property_earnings_path(property)},
      {name: "Campaigns", path: property_campaigns_path(property)},
      {name: "Comments", path: property_comments_path(property), validation: authorized_user.can_view_comments?},
      {name: "Settings", path: edit_property_path(property)}
    ]
  end

  def properties_for_select
    @properties_for_select ||= Property.active.or(Property.pending).order(Property.arel_table[:name].lower).map { |p| [p.name, p.id] }
  end

  def property_types_for_select
    ENUMS::PROPERTY_TYPES.values.map { |val| [val.humanize, val] }
  end

  def property_statuses_for_select
    ENUMS::PROPERTY_STATUSES.values.map { |val| [val.humanize, val] }
  end

  def property_responsive_behaviors_for_select
    [
      ["Show ad using the configured template and theme", ENUMS::PROPERTY_RESPONSIVE_BEHAVIORS::NONE],
      ["Show ad using a sticky footer that can be closed by the user", ENUMS::PROPERTY_RESPONSIVE_BEHAVIORS::FOOTER],
      ["Do not show ads", ENUMS::PROPERTY_RESPONSIVE_BEHAVIORS::HIDE]
    ]
  end

  def property_status_title(status)
    return status.humanize unless status.inquiry.pending?

    "Awaiting Administrator Approval"
  end
end
