class ApplicationComponent < ViewComponent::Base
  def current_user
    helpers.current_user
  end

  def authorized_user
    helpers.authorized_user
  end
end
