class MasqueradesOverrideController < Devise::MasqueradesController
  protected

  def after_back_masquerade_path_for(resource)
    binding.pry
    user_path("me")
  end

  def after_back_masquerade_path_for(resource)
    user_path("me")
  end
end
