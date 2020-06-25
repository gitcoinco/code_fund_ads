module CampaignsHelper
  def campaign_tabs(campaign)
    tabs = [
      {name: "Overview", path: campaign_path(campaign), active: :exact},
      {name: "Daily Stats", path: campaign_dailies_path(campaign)},
      {name: "Creatives", path: campaign_creatives_path(campaign)},
      {name: "Properties", path: campaign_properties_path(campaign)},
      {name: "Countries", path: campaign_countries_path(campaign)},
      {name: "Comments", path: campaign_comments_path(campaign), validation: authorized_user.can_view_comments?},
      {name: "Settings", path: edit_campaign_path(campaign)}
    ]
    if authorized_user.can_admin_system? && campaign.campaign_bundle
      tabs << {
        name: "Estimate",
        path: campaign_estimate_path(id: campaign.id, campaign_id: campaign.id) # TODO Refactor
      }
    end
    tabs
  end

  def campaign_reports_email_error_message(campaign)
    return "Email not sent! Please verify that data exists for the selected dates." unless campaign.summary(@start_date, @end_date)
    "Email not sent! Please verify the email address."
  end

  def creatives_for_select
    Creative.select(:id, :user_id, :name).order(:name).map do |creative|
      [creative.name, creative.id, data: {parent_id: creative.user_id}]
    end
  end

  def campaign_statuses_for_select
    ENUMS::CAMPAIGN_STATUSES.values.map { |val| [val.humanize, val] }
  end

  def campaign_status_html(status)
    case ENUMS::CAMPAIGN_STATUSES[status]
    when "active" then tag.span(class: "fas fa-circle text-success", title: "Active", data: tooltip_expando(placement: "left"))
    when "paused" then tag.span(class: "fas fa-circle text-info", title: "Paused", data: tooltip_expando(placement: "left"))
    when "pending" then tag.span(class: "fas fa-circle text-warning", title: "Pending", data: tooltip_expando(placement: "left"))
    when "archived" then tag.span(class: "fas fa-circle text-muted", title: "Archived", data: tooltip_expando(placement: "left"))
    end
  end

  def countries_with_codes_for_subregion(subregion)
    Country.where(subregion: subregion).map do |country|
      [country.name, country.iso_code]
    end
  end

  def split_winner?(split_experiment, split_alternative)
    return false unless split_experiment && split_alternative
    return false unless split_experiment.winner
    split_alternative.name == split_experiment.winner.name
  end

  def split_loser?(split_experiment, split_alternative)
    return false unless split_experiment && split_alternative
    return false unless split_experiment.winner
    split_alternative.name != split_experiment.winner.name
  end

  def split_experiment_confidence_level(z_score)
    return z_score if z_score.is_a? String

    z = BigDecimal(z_score.to_s).round(3).to_f.abs

    if z >= 2.58
      "99%"
    elsif z >= 1.96
      "95%"
    elsif z >= 1.65
      "90%"
    else
      "Insufficient"
    end
  end

  def remaining_days_label(campaign)
    if campaign.pending?
      "Starts #{distance_of_time_in_words_to_now campaign.start_date.beginning_of_day} from now"
    elsif campaign.active?
      "Completes #{distance_of_time_in_words_to_now campaign.end_date.end_of_day} from now"
    elsif campaign.archived?
      "Completed #{distance_of_time_in_words_to_now campaign.end_date.end_of_day} ago"
    end
  end
end
