class AvatarComponent < ApplicationComponent
  VALID_AVATAR_SIZES = %w[xs sm md lg xl xxl]

  def initialize(user: nil, size: "md")
    @user = user
    @size = fetch_or_fallback(VALID_AVATAR_SIZES, size, "md")
  end

  private

  attr_reader :user, :size

  def classes
    classes = ["user-avatar"]
    classes.push("user-avatar-#{size}")
    classes.compact
  end

  def avatar_image_url
    return unless user
    return user.avatar if user.avatar.attached?

    user_gravatar_url
  end

  def user_gravatar_url
    @user_gravatar_url ||= user.gravatar_url("identicon")
  end

  def render?
    user.present?
  end
end
