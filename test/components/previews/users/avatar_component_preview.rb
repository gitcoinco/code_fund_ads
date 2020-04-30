# You can access these previews by visiting:
# http://localhost:3000/rails/view_components/users/avatar_component/TEST_NAME

module Users
  class AvatarComponentPreview < ViewComponent::Preview
    layout "component_preview"

    def extra_small
      render(Users::AvatarComponent.new(user: User.first, size: "xs"))
    end

    def small
      render(Users::AvatarComponent.new(user: User.first, size: "sm"))
    end

    def medium
      render(Users::AvatarComponent.new(user: User.first))
    end

    def large
      render(Users::AvatarComponent.new(user: User.first, size: "lg"))
    end

    def extra_large
      render(Users::AvatarComponent.new(user: User.first, size: "xl"))
    end

    def extra_extra_large
      render(Users::AvatarComponent.new(user: User.first, size: "xxl"))
    end
  end
end
