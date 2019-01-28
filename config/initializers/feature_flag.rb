class FeatureFlag
  def self.enabled?(feature, user = nil)
    @env_enabled ||= ENV["ENABLED_FEATURES"].split(",").map(&:to_sym)
    return true if @env_enabled.include?(feature)
    return true if user&.administrator?
    false
  end
end
