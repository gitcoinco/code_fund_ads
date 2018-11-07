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
    relation = User.select(:id, :company, :first_name, :last_name).order(:company, :first_name, :last_name)
    relation = relation.send(role) if role
    relation
  end

  def companies_for_select
    User.sponsor.where.not(company: nil).order(User.arel_table[:company].lower).pluck(:company).uniq
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
end
