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

  def user_roles_for_select
    ENUMS::USER_ROLES.values
  end

  def image_formats_for_select
    ENUMS::IMAGE_FORMATS.values
  end

  def companies_for_select
    User.advertiser.where.not(company_name: nil).order(User.arel_table[:company_name].lower).pluck(:company_name).uniq
  end

  def ad_templates_for_select
    ENUMS::AD_TEMPLATES.values
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

  def badge_for_role(role, wrap_class: "")
    case role
    when "administrator"
      tag.span(
        tag.span("", class: "fas fa-key content-centered", style: "top: 5px; left: 5px; position: absolute;"),
        class: "btn btn-icon btn-dark btn-xs rounded-circle position-relative #{wrap_class}",
        title: "Administrator",
        data: tooltip_expando
      )
    when "advertiser"
      tag.span(
        tag.span("", class: "fas fa-ad content-centered", style: "top: 5px; left: 5px; position: absolute;"),
        class: "btn btn-icon btn-success btn-xs rounded-circle position-relative #{wrap_class}",
        title: "Advertiser",
        data: tooltip_expando
      )
    when "publisher"
      tag.span(
        tag.span("", class: "fas fa-code content-centered", style: "top: 5px; left: 3px; position: absolute;"),
        class: "btn btn-icon btn-primary btn-xs rounded-circle position-relative #{wrap_class}",
        title: "Publisher",
        data: tooltip_expando
      )
    end
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

  def sortable_tr(column, title = nil)
    title   ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_up   = link_to(tag.span("", class: "fas fa-angle-up u-datatable__thead-icon"), column: column, direction: "asc")
    link_down = link_to(tag.span("", class: "fas fa-angle-down u-datatable__thead-icon"), column: column, direction: "desc")

    if params[:column] == column
      link_up = link_to(tag.span("", class: "fas fa-angle-up u-datatable__thead-icon text-primary"), column: column, direction: "asc") if direction == "desc"
      link_down = link_to(tag.span("", class: "fas fa-angle-down u-datatable__thead-icon text-primary"), column: column, direction: "desc") if direction == "asc"
    end

    tr = <<~EOS
      <th scope="col" class="font-weight-medium sorting" tabindex="0" rowspan="1" colspan="1">
        <div class="d-flex justify-content-between align-items-center">
          #{title}
          <div class="ml-2">
            #{link_up}
            #{link_down}
          </div>
        </div>
      </th>
    EOS

    tr.html_safe
  end

  def pagy_entries(pagy)
    start = pagy.offset + 1
    finish = start + pagy.items - 1
    count = pagy.count
    tag.small("Showing #{start} to #{finish} of #{count} Entries", class: "text-secondary").html_safe
  end
end
