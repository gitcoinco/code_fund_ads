module UsersHelper
  def avatar_image_url(user)
    return unless user
    return user.avatar if user.avatar.attached?

    user.gravatar_url("identicon")
  end

  def user_avatar_image_tag(user, tag_class = "")
    return unless user

    gravatar_url = user.gravatar_url("identicon")
    image_tag(
      avatar_image_url(user),
      class: tag_class,
      onerror: "this.error=null;this.src=\"#{gravatar_url}\""
    )
  end

  def default_dashboard_path(user)
    return administrator_dashboards_path if user.has_role?("administrator")
    return advertiser_dashboards_path if user.has_role?("advertiser")
    return publisher_dashboards_path if user.has_role?("publisher")
    manage_job_postings_path
  end

  def user_status_color(status)
    ENUMS::USER_STATUS_COLORS[status] || "muted"
  end
end
