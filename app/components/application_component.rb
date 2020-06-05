class ApplicationComponent < ViewComponent::Base
  include Frontend::TableHelper

  delegate :rich_text_area, :current_user, :authorized_user, to: :helpers

  def fetch_or_fallback(allowed_values, given_value, fallback)
    if allowed_values.include?(given_value)
      given_value
    else
      raise ArgumentError, "invalid value '#{given_value}' supplied to fetch_or_fallback" if Rails.env.development?
      fallback
    end
  end

  def status_color(status)
    case status.to_sym
    when :archived
      "secondary"
    when :blacklisted
      "dark"
    when :paused
      "info"
    when :pending
      "warning"
    when :rejected
      "danger"
    when :unconfigured
      "warning"
    else
      "success"
    end
  end
end
