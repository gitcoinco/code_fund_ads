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
    {toggle: "tooltip", placement: "top"}.merge(options)
  end

  def users_for_select(role: nil)
    relation = User.select(:id, :company_name, :first_name, :last_name).order(:company_name, :first_name, :last_name)
    relation = relation.send(role) if role
    relation
  end

  def user_roles_for_select
    ENUMS::USER_ROLES.values.map { |f| [f.humanize, f] }
  end

  def image_formats_for_select
    ENUMS::IMAGE_FORMATS.values.map { |f| [f.humanize, f] }
  end

  def companies_for_select
    User.advertisers.where.not(company_name: nil).order(User.arel_table[:company_name].lower).map { |user| [user.company_name, user.id] }
  end

  def organizations_for_select
    Organization.order(Organization.arel_table[:name].lower).map { |org| [org.name, org.id] }
  end

  def advertisers_for_select
    User.advertisers.select(:id, :first_name, :last_name).order(:first_name).map { |user| [user.name, user.id] }
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
        text: message,
      }
      text = "<script>new Noty(#{body.to_json}).show();</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def details_li(label, &block)
    render partial: "/@shared/details_li", locals: {label: label, block: block}
  end

  def sortable_tr(column, title = nil)
    title   ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    selected  = nil

    if params[:column] == column
      selected = "up" if direction == "desc"
      selected = "down" if direction == "asc"
    end

    render "/@shared/sortable_tr", title: title, selected: selected, column: column
  end

  def pagy_entries(pagy)
    start = pagy.offset + 1
    finish = start + pagy.items - 1
    count = pagy.count
    tag.small("Showing #{start} to #{finish} of #{count} Entries", class: "text-secondary").html_safe
  end

  def find_version_author(version)
    User.find_version_author(version)
  end

  def diff(content1, content2)
    changes = Diffy::Diff.new(content1, content2,
      include_plus_and_minus_in_html: true,
      include_diff_info: true)
    changes.to_s.present? ? changes.to_s(:html).html_safe : "No Changes"
  end

  def date_range_picker
    render "/@shared/date_range_picker"
  end

  def sparkline(values, width: 100, height: 30, stroke_width: 3, color: "green", filled: true)
    svg_class = "sparkline sparkline--#{color}#{" sparkline--filled" if filled}"
    render "/@shared/widgets/sparkline_graph", values: values, width: width, height: height, stroke_width: stroke_width, svg_class: svg_class
  end
end
