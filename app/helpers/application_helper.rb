# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def page_heading(action, subject, subtitle: nil, icon: nil)
    render "/@shared/page_heading", action: action, subject: subject, subtitle: subtitle, icon: icon
  end

  def breadcrumbs
    @breadcrumbs = yield
  end

  def pseudo_row_divider
    @pseudo_row_divider ||= render("/@shared/forms/pseudo_row_divider")
  end

  def classes(options = {})
    list = []
    options.each { |k, v| list << k if v }
    list.join " "
  end

  def tooltip_expando(options = {})
    { toggle: "tooltip", placement: "top" }.merge(options)
  end

  def users_for_select(role: nil)
    relation = User.select(:id, :company_name, :first_name, :last_name).order(:company_name, :first_name, :last_name)
    relation = relation.send(role) if role
    relation
  end

  def companies_for_select
    User.advertiser.where.not(company_name: nil).order(User.arel_table[:company_name].lower).pluck(:company_name).uniq
  end

  def templates_for_select
    Template.select(:id, :name).order(:name)
  end

  def languages_for_select
    ENUMS::LANGUAGES.values
  end

  def countries_for_select
    ENUMS::COUNTRIES.values.zip ENUMS::COUNTRIES.keys
  end

  def keywords_for_select
    ENUMS::KEYWORDS.keys
  end

  def badge_for_count(count)
    return nil if count == 0
    return tag.span(count, class: "badge badge-pill badge-success opacity-60") if count.between?(1, 2)
    tag.span count, class: "badge badge-pill badge-success"
  end

  def ga_tag
    return nil unless ENV["GA_TRACKING_ID"].present?
    render("/@shared/scripts/google_analytics", id: ENV["GA_TRACKING_ID"])
  end

  def support_widget_tag
    return nil unless ENV["GROOVE_WIDGET_ID"].present?
    render("/@shared/scripts/groove", id: ENV["GROOVE_WIDGET_ID"])
  end

  def noty_flash
    flash_messages = []
    flash.each do |type, message|
      type = "success" if type == "notice"
      type = "error"   if type == "alert"
      body = {
        type: type,
        text: message
      }
      text = "<script>new Noty(#{body.to_json}).show();</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
