module Keywordable
  extend ActiveSupport::Concern

  included do
    before_validation :sanitize_keywords, :sanitize_negative_keywords
  end

  def sanitize_keywords
    self.keywords = (keywords & ENUMS::KEYWORDS.keys).sort
  end

  def sanitize_negative_keywords
    return unless respond_to?(:negative_keywords)
    self.negative_keywords = (negative_keywords & ENUMS::KEYWORDS.keys).sort
  end
end
