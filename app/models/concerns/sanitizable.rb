module Sanitizable
  extend ActiveSupport::Concern

  module ClassMethods
    def attribute_names_to_sanitize
      @attribute_names_to_sanitize ||= []
    end

    def sanitize(*attribute_names)
      attribute_names_to_sanitize.concat attribute_names
    end
  end

  included do
    before_save :sanitize_attributes
  end

  delegate :attribute_names_to_sanitize, to: "self.class"

  def sanitize_attributes
    attribute_names_to_sanitize.each do |name|
      self[name] = CGI.unescapeHTML(Loofah.fragment(self[name].to_s).scrub!(:prune).to_s.gsub(/'/, "′"))
    end
  end
end
