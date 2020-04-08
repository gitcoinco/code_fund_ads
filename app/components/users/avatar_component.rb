module Users
  class AvatarComponent < ViewComponent::Base
    VALID_AVATAR_SIZES = %w[xs sm lg xl xxl]

    def initialize(user:, size: "md")
      @user = user
      @size = size
    end

    def avatar_classes
      VALID_AVATAR_SIZES.include?(@size) ? "user-avatar user-avatar-#{@size}" : "user-avatar"
    end

    def avatar_image_url
      return unless @user
      return @user.avatar if @user.avatar.attached?

      user_gravatar_url
    end

    private

    def user_gravatar_url
      @user.gravatar_url("identicon")
    end
  end
end
