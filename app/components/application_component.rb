class ApplicationComponent < ViewComponent::Base
  def current_user
    helpers.current_user
  end

  def authorized_user
    helpers.authorized_user
  end

  def valid_variant(variant)
    ENUMS::VARIANTS[variant.to_s].present? ? variant.to_s : ENUMS::VARIANTS::PRIMARY
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
