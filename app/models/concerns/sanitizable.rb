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
      self[name] = sanitize_value(self[name])
    end
  end

  def sanitize_value(value)
    clean_html = Loofah.fragment(value.to_s).scrub!(:strip).to_s.tr("'", "′")
    pretty_html = clean_html.gsub(/(\<br\>){3,}/i, "<br><br>").tr("\n", "")
    CGI.unescapeHTML pretty_html
  end
end
