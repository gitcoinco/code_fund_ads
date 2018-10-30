# frozen_string_literal: true

require "digest/md5"

class ApplicationSearchRecord
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include GlobalID::Identification

  cattr_accessor :abstract_class
  self.abstract_class = true

  delegate :model_name, to: "self.class"

  def cache_key
    "#{self.class.name.underscore}/#{Digest::MD5.hexdigest id}"
  end

  def id
    Base64.encode64 to_h.to_json
  end

  def self.find(id)
    new **JSON.parse(Base64.decode64(id)).symbolize_keys
  end

  def to_h
    @attributes.dup
  end

  def present?
    @attributes.values.flatten.join.present?
  end

  def blank?
    !present?
  end

  alias_method :empty?, :blank?

  def persisted?
    false
  end

  def apply(relation)
    message = "ApplicationSearchRecord#apply is abstract & must be implemented by subclasses"
    raise NotImplementedError.new(message)
  end

  def apply_and_transform(relation, to: :gid_param)
    case to
    when :id then return apply(relation).pluck(:id)
    when :gid then return apply(relation).select(:id).map(&:to_gid)
    when :gid_param then return apply(relation).select(:id).map(&:to_gid_param)
    end
    apply relation
  end
end
