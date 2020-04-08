module ApplicationHelper
  include Pagy::Frontend

  def navigable_expandos(options = {})
    {
      scoped_by: @scoped_by,
      sorted_by: @sorted_by,
      sorted_direction: @sorted_direction,
      page: @page
    }.merge(options)
  end

  def active_campaigns_for_current_organization
    Current.organization&.campaigns&.active
  end

  def page_heading(action, subject, title: nil, subtitle: nil, icon: nil, datepicker: false)
    render partial: "/shared/page_heading", locals: {action: action, subject: subject, title: title, subtitle: subtitle, icon: icon, datepicker: datepicker}
  end

  def breadcrumbs
    @breadcrumbs = yield
  end

  def classes(options = {})
    list = []
    options.each { |k, v| list << k if v }
    list.join " "
  end

  def tooltip_expando(options = {})
    {toggle: "tooltip", placement: "top"}.merge(options)
  end

  def status_color(status)
    ENUMS::STATUS_COLORS[status]
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

  def user_statuses_for_select
    ENUMS::USER_STATUSES.values.map { |f| [f.humanize, f] }
  end

  def organization_users_for_select
    Current.organization.users.advertisers.sort_by(&:name).map { |user| [user.name, user.id] }
  end

  def account_managers_for_select
    User.account_managers.sort_by(&:name).map { |user| [user.name, user.id] }
  end

  def organizations_for_select
    Organization.order(Organization.arel_table[:name].lower).map { |org| [org.name, org.id] }
  end

  def user_organizations_for_select
    return Organization.order(Organization.arel_table[:name].lower) if authorized_user.can_admin_system?
    current_user.organizations.order(Organization.arel_table[:name].lower)
  end

  def currencies_for_select
    Money::Currency.table.values.sort_by { |currency| currency[:name] }.map do |currency|
      ["#{currency[:name]} (#{currency[:iso_code]})", currency[:iso_code]]
    end
  end

  def ad_templates_for_select
    ENUMS::AD_TEMPLATES.values
  end

  def languages_for_select
    ENUMS::LANGUAGES.values
  end

  def countries_for_select
    Country.all.map { |country| [country.name, country.iso_code] }
  end

  def countries_with_pricing_for_select(base_ecpm)
    Country.all.map { |country| ["#{country.name} (#{country.ecpm(base: base_ecpm).format})", country.iso_code] }
  end

  def provinces_for_select
    Province.all.map { |province| [province.full_name, province.id] }
  end

  def provinces_for_stimulus
    Province.all.map { |province|
      {id: province.id, countryCode: province.country_code, name: province.full_name}
    }.to_json
  end

  def scheduled_organization_report_datasets_for_select
    ENUMS::SCHEDULED_ORGANIZATION_REPORT_DATASETS.values.map { |val| [val.humanize.titleize, val] }
  end

  def scheduled_organization_report_frequencies_for_select
    ENUMS::SCHEDULED_ORGANIZATION_REPORT_FREQUENCIES.values.map { |val| [val.humanize.titleize, val] }
  end

  def keywords_for_select
    ENUMS::KEYWORDS.keys
  end

  def badge_for_count(count)
    return nil if count == 0
    return tag.span(count, class: "badge badge-pill badge-success opacity-60") if count.between?(1, 2)
    tag.span count, class: "badge badge-pill badge-success"
  end

  def badge_for_role(role, wrap_class: "")
    case role
    when "administrator"
      tag.div(
        tag.span("", class: "fas fa-key content-centered"),
        class: "tile tile-circle tile-sm bg-dark #{wrap_class}",
        title: "Administrator",
        data: tooltip_expando
      )
    when "advertiser"
      tag.div(
        tag.span("", class: "fas fa-ad content-centered"),
        class: "tile tile-circle tile-sm bg-success #{wrap_class}",
        title: "Advertiser",
        data: tooltip_expando
      )
    when "publisher"
      tag.div(
        tag.span("", class: "fas fa-code content-centered"),
        class: "tile tile-circle tile-sm bg-primary #{wrap_class}",
        title: "Publisher",
        data: tooltip_expando
      )
    end
  end

  def noty_flash
    flash_messages = []
    flash.each do |type, message|
      next unless message.is_a? String
      type = "success" if type == "notice"
      type = "error" if type == "alert"
      body = {
        type: type,
        text: message
      }
      text = "<script>new Noty(#{body.to_json}).show();</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def details_li(label, &block)
    render partial: "/shared/details_li", locals: {label: label, block: block}
  end

  def pagy_entries(pagy)
    start = pagy.offset + 1
    finish = start + pagy.items - 1
    count = pagy.count
    tag.small("Showing #{start} to #{finish} of #{count} Entries", class: "text-muted").html_safe
  end

  def find_version_author(version)
    User.find_version_author(version)
  end

  def diff(content1, content2)
    changes = Diffy::Diff.new(content1, content2, include_plus_and_minus_in_html: true, include_diff_info: false)
    changes.to_s.present? ? changes.to_s(:html).html_safe : "No Changes"
  end

  def sparkline(values, width: 100, height: 30, stroke_width: 3, color: "green", filled: true)
    svg_class = "sparkline sparkline--#{color}#{" sparkline--filled" if filled}"
    render "/shared/widgets/sparkline_graph", values: values, width: width, height: height, stroke_width: stroke_width, svg_class: svg_class
  end

  def calc_percentage(numerator, denominator)
    return 0 if denominator.zero?
    numerator / denominator.to_f
  end
end
