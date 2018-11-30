class MasqueradesOverrideController < Devise::MasqueradesController
  private

  def after_masquerade_path_for(resource)
    user_path(resource.id)
  end
end
