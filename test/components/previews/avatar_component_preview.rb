# You can access these previews by visiting:
# http://localhost:3000/rails/view_components/avatar_component/TEST_NAME

class AvatarComponentPreview < ViewComponent::Preview
  def extra_small
    render(AvatarComponent.new(user: User.first, size: "xs"))
  end

  def small
    render(AvatarComponent.new(user: User.first, size: "sm"))
  end

  def medium
    render(AvatarComponent.new(user: User.first))
  end

  def large
    render(AvatarComponent.new(user: User.first, size: "lg"))
  end

  def extra_large
    render(AvatarComponent.new(user: User.first, size: "xl"))
  end

  def extra_extra_large
    render(AvatarComponent.new(user: User.first, size: "xxl"))
  end
end
