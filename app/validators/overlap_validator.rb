class OverlapValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if (value & options[:values]).present?
    key = attribute.to_s.delete_suffix("_ids").pluralize.to_sym
    record.errors[key] << (options[:message] || "are invalid")
  end
end
