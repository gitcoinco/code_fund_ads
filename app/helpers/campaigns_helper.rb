# frozen_string_literal: true

module CampaignsHelper
  def users_for_select
    User.sponsor.select(:id, :company, :first_name, :last_name).order(:company, :first_name, :last_name)
  end

  def creatives_for_select
    Creative.select(:id, :user_id, :name).order(:name).map do |creative|
      [creative.name, creative.id, data: { parent_id: creative.user_id }]
    end
  end

  def countries_for_select
    ENUMS::COUNTRIES.values.zip ENUMS::COUNTRIES.keys
  end

  def campaign_status_html(status)
    case ENUMS::CAMPAIGN_STATUSES[status]
    when "active" then tag.span(class: "fas fa-circle text-success", title: "Active", data: tooltip_expando(placement: "left"))
    when "pending" then  tag.span(class: "fas fa-circle text-warning", title: "Pending", data: tooltip_expando(placement: "left"))
    when "archived" then  tag.span(class: "fas fa-circle text-muted", title: "Archived", data: tooltip_expando(placement: "left"))
    end
  end
end
