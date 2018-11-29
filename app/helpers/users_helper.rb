module UsersHelper
  
  def avatar_image_url(user)
    return user.avatar if user.avatar.attached?
    user.gravatar_url("404")
  end

  def user_avatar_image_tag(user, className = "img-fluid rounded-circle")
    image_tag(
      avatar_image_url(user),
      class: className,
      data: {
        controller: "fallback-image",
        fallback_image_url: user_identicon_url(user.id)
      },
      alt: user.full_name
    )
  end
end
