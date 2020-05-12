class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value = record[attribute] = value.to_s.strip
    return if value.blank?
    return if url_valid?(value)
    record.errors[attribute] << (options[:message] || "is invalid")
  end

  # a URL may be technically well-formed but may
  # not actually be valid, so this checks for both.
  def url_valid?(url)
    url = url.to_s.strip
    url = begin
            URI.parse(url)
          rescue
            false
          end
    url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  end
end
