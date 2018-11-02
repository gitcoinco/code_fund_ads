# frozen_string_literal: true

module CampaignsHelper
  def creatives_for_select
    Creative.select(:id, :user_id, :name).order(:name).map do |creative|
      [creative.name, creative.id, data: { parent_id: creative.user_id }]
    end
  end

  def campaign_statuses_for_select
    ENUMS::CAMPAIGN_STATUSES.values.zip ENUMS::CAMPAIGN_STATUSES.keys
  end

  def campaign_status_html(status)
    case ENUMS::CAMPAIGN_STATUSES[status]
    when "active" then tag.span(class: "fas fa-circle text-success", title: "Active", data: tooltip_expando(placement: "left"))
    when "pending" then  tag.span(class: "fas fa-circle text-warning", title: "Pending", data: tooltip_expando(placement: "left"))
    when "archived" then  tag.span(class: "fas fa-circle text-muted", title: "Archived", data: tooltip_expando(placement: "left"))
    end
  end

  def campaign_status_badge_html(status)
    style = {
      "active"   => { icon: "check", color: "success" },
      "pending"  => { icon: "pause", color: "info" },
      "archived" => { icon: "archive", color: "dark" }
    }[ENUMS::CAMPAIGN_STATUSES[status]]

    tag.span(class: "u-badge u-badge-border-#{style[:color]} u-badge--md u-badge-pos--bottom-right-0 rounded-circle") do
      tag.span(class: "fa fa-#{style[:icon]}")
    end
  end
  
end
