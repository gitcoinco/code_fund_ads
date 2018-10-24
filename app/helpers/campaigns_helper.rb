# frozen_string_literal: true

module CampaignsHelper
  def users_for_select
    User.sponsor.select(:id, :company, :first_name, :last_name).order(:company, :first_name, :last_name)
  end

  def creatives_for_select
    Creative.select(:id, :user_id, :name).order(:name).map do |creative|
      [creative.name, creative.id, data: { user_id: creative.user_id }]
    end
  end

  def countries_for_select
    ENUMS[:countries].map { |abbr, name| [name, abbr] }
  end
end
