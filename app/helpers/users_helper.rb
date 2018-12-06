module UsersHelper
  def avatar_image_url(user)
    return user.avatar if user.avatar.attached?
    user.gravatar_url("404")
  end

  def user_avatar_image_tag(user, tag_class = "img-fluid rounded-circle")
    image_tag(
      avatar_image_url(user),
      class: tag_class,
      data: {
        controller: "fallback-image",
        fallback_image_url: user_identicon_url(user.id),
      },
      alt: user.full_name
    )
  end

  def default_dashboard_path(user)
    return dashboard_path("administrator") if user.has_role?("administrator")
    return dashboard_path("advertiser")    if user.has_role?("advertiser")
    dashboard_path("publisher")
  end
end
