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

  def property_status_html(status)
    case ENUMS::PROPERTY_STATUSES[status]
    when "pending"     then tag.span(class: "fas fa-circle text-warning", title: "Pending",     data: tooltip_expando)
    when "active"      then tag.span(class: "fas fa-circle text-success", title: "Active",      data: tooltip_expando)
    when "rejected"    then tag.span(class: "fas fa-circle text-danger",  title: "Rejected",    data: tooltip_expando)
    when "archived"    then tag.span(class: "fas fa-circle text-muted",   title: "Archived",    data: tooltip_expando)
    when "blacklisted" then tag.span(class: "fas fa-circle text-dark",    title: "Blacklisted", data: tooltip_expando)
    end
  end
end
