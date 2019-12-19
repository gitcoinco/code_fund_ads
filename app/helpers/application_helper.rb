module ApplicationHelper
  include Pagy::Frontend

  def active_campaigns_for_current_organization
    Current.organization&.campaigns&.active
  end

  # TODO: move these to Country or a presentable concern
  def country_display_name(iso_code)
    country = Country.find(iso_code)
    return "#{country.emoji_flag} #{truncate country.name, length: 30} (#{iso_code})" if country
    iso_code
  end

  def country_short_name(iso_code)
    country = Country.find(iso_code)
    return tag.span("#{country.emoji_flag} #{iso_code}", title: "country.name") if country
    iso_code
  end

  def safe_camo(url)
    camo url.to_s
  rescue
    asset_path "pixel.gif"
  end

  def page_heading(action, subject, title: nil, subtitle: nil, icon: nil, datepicker: false)
    render partial: "/shared/page_heading", locals: {action: action, subject: subject, title: title, subtitle: subtitle, icon: icon, datepicker: datepicker}
  end

  def breadcrumbs
    @breadcrumbs = yield
  end

  def pseudo_row_divider
    ActiveSupport::Deprecation.warn("pseudo_row_divider will be removed after the redesign is complete.")
    @pseudo_row_divider ||= render("/shared/forms/pseudo_row_divider")
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

  def user_statuses_for_select
    ENUMS::USER_STATUSES.values.map { |f| [f.humanize, f] }
  end

  def advertisers_for_select
    User.advertisers.includes(:organization).sort_by(&:scoped_name).map { |user| [user.scoped_name, user.id] }
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

  def ga_tag
    return nil unless ENV["GA_TRACKING_ID"].present?
    render("/shared/scripts/google_analytics", id: ENV["GA_TRACKING_ID"])
  end

  def ga_tag_manager_header
    return nil unless ENV["GA_TAG_MANAGER_ID"].present?
    render("/shared/scripts/google_tag_manager_header", id: ENV["GA_TAG_MANAGER_ID"])
  end

  def ga_tag_manager_footer
    return nil unless ENV["GA_TAG_MANAGER_ID"].present?
    render("/shared/scripts/google_tag_manager_footer", id: ENV["GA_TAG_MANAGER_ID"])
  end

  def headway_tag
    return nil unless ENV["HEADWAY_ID"].present?
    render("/shared/scripts/headway", id: ENV["HEADWAY_ID"])
  end

  def intercom_tag
    ActiveSupport::Deprecation.warn("intercom_tag will be removed after the redesign is complete.")
    return nil unless ENV["INTERCOM_APP_ID"].present? && ENV["INTERCOM_SECRET_KEY"].present?
    intercom_settings = {app_id: ENV["INTERCOM_APP_ID"]}
    if current_user
      user_hash = OpenSSL::HMAC.hexdigest("sha256", ENV["INTERCOM_SECRET_KEY"], current_user.id.to_s)

      intercom_settings = intercom_settings.merge({
        user_id: current_user.id.to_s,
        user_hash: user_hash,
        name: current_user.full_name,
        email: current_user.email,
        created_at: current_user.created_at.to_i,
      })
    end
    render("/shared/scripts/intercom", intercom_settings: intercom_settings)
  end

  def codefund_analytics_tag
    ActiveSupport::Deprecation.warn("codefund_analytics_tag will be removed after the redesign is complete.")
    return nil unless ENV["CODEFUND_ANALYTICS_KEY"].present?
    render("/shared/scripts/codefund_analytics", id: ENV["CODEFUND_ANALYTICS_KEY"])
  end

  def support_widget_tag
    ActiveSupport::Deprecation.warn("support_widget_tag will be removed after the redesign is complete.")
    return nil unless ENV["GROOVE_WIDGET_ID"].present?
    render("/shared/scripts/groove", id: ENV["GROOVE_WIDGET_ID"])
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
      type = "success" if type == "notice"
      type = "error" if type == "alert"
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
    render partial: "/shared/details_li", locals: {label: label, block: block}
  end

  def sortable_tr(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    selected = nil

    if params[:column] == column
      selected = "up" if direction == "desc"
      selected = "down" if direction == "asc"
    end

    render "/shared/sortable_tr", title: title, selected: selected, column: column
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
    changes = Diffy::Diff.new(content1, content2,
      include_plus_and_minus_in_html: true,
      include_diff_info: true)
    changes.to_s.present? ? changes.to_s(:html).html_safe : "No Changes"
  end

  def date_range_picker
    ActiveSupport::Deprecation.warn("date_range_picker will be removed after the redesign is complete.")
    render "/shared/date_range_picker"
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
