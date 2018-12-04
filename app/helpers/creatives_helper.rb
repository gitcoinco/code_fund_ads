module CreativesHelper
  def small_images_for_select(user)
    user.small_images(true).map { |img| [img.display_name, img.id] }
  end

  def large_images_for_select(user)
    user.large_images(true).map { |img| [img.display_name, img.id] }
  end

  def wide_images_for_select(user)
    user.wide_images(true).map { |img| [img.display_name, img.id] }
  end
end
