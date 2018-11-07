# frozen_string_literal: true

module PropertiesHelper
  def property_types_for_select
    ENUMS::PROPERTY_TYPES.values
  end

  def property_statuses_for_select
    ENUMS::PROPERTY_STATUSES.values
  end

  def property_status_html(status)
    case ENUMS::PROPERTY_STATUSES[status]
    when "pending" then  tag.span(class: "fas fa-circle text-warning", title: "Pending", data: tooltip_expando(placement: "left"))
    when "active" then tag.span(class: "fas fa-circle text-success", title: "Active", data: tooltip_expando(placement: "left"))
    when "rejected" then  tag.span(class: "fas fa-circle text-danger", title: "Rejected", data: tooltip_expando(placement: "left"))
    when "archived" then  tag.span(class: "fas fa-circle text-muted", title: "Archived", data: tooltip_expando(placement: "left"))
    when "blacklisted" then  tag.span(class: "fas fa-circle text-dark", title: "Blacklisted", data: tooltip_expando(placement: "left"))
    end
  end
end
