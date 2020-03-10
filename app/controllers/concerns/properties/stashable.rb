module Properties
  module Stashable
    extend ActiveSupport::Concern

    def stash_property(property)
      session[:stashed_property] = property&.to_stashable_attributes
    end

    def stashed_property
      property = property_id > 0 ? Property.find(property_id) : Property.new
      property.assign_attributes stashed_property_params.except(:id) unless property_changed?
      property
    end

    private

    def property_id
      p = try(:params) || try(:url_params) || {}
      (p[:controller] == "properties" ? p[:id] : p[:property_id]).to_i
    end

    def property_changed?
      property_id != stashed_property_params[:id]
    end

    def stashed_property_params
      @stashed_property_params ||= HashWithIndifferentAccess.new(
        session[:stashed_property] || {
          temporary_id: Property.count + 1,
          status: ENUMS::PROPERTY_STATUSES::PENDING,
          ad_template: ENUMS::AD_TEMPLATES::DEFAULT,
          ad_theme: ENUMS::AD_THEMES::LIGHT
        }
      )
    end
  end
end
