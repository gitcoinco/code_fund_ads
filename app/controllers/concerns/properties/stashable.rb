module Properties
  module Stashable
    extend ActiveSupport::Concern

    def stash_property(property)
      session[:stashed_property] = property&.to_stashable_attributes
    end

    def stashed_property
      Property.new stashed_property_params
    end

    def stashed_property_params
      session[:stashed_property] || {}
    end
  end
end
