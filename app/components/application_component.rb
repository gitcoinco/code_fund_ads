class ApplicationComponent < ViewComponent::Base
  include Frontend::TableHelper

  def current_user
    helpers.current_user
  end

  def authorized_user
    helpers.authorized_user
  end

  delegate :rich_text_area, to: :helpers

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
