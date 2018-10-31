# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def page_heading(action, subject, subtitle: nil)
    render "/@shared/page_heading", action: action, subject: subject, subtitle: subtitle
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

  def templates_for_select
    Template.select(:id, :name).order(:name)
  end

  def countries_for_select
    ENUMS::COUNTRIES.values.zip ENUMS::COUNTRIES.keys
  end

  def topic_categories_for_select
    ENUMS::TOPIC_CATEGORIES.values
  end

  def programming_languages_for_select
    ENUMS::PROGRAMMING_LANGUAGES.values
  end
end
