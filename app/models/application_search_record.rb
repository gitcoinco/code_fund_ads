require "digest/md5"

class ApplicationSearchRecord
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include GlobalID::Identification

  cattr_accessor :abstract_class
  self.abstract_class = true

  delegate :model_name, to: "self.class"
  delegate :subject, to: "self.class"

  class << self
    def find(id)
      new(**JSON.parse(Base64.decode64(id)).symbolize_keys)
    end

    def subject
      name.sub(/Search\z/, "").classify.constantize
    end
  end

  def initialize(fields = [], attrs = {})
    @fields = fields.map(&:to_s)
    @attributes = HashWithIndifferentAccess.new(attrs.try(:to_unsafe_hash) || attrs || {})
    @attributes.keep_if do |key, value|
      @fields.include?(key.to_s) && value.present?
    end
  end

  def id
    Base64.encode64 to_h.to_json
  end

  def to_h(removed_attr = "")
    return @attributes.dup unless removed_attr.present?
    @attributes.dup.tap do |attrs|
      attrs.delete removed_attr.to_sym
    end
  end

  def searched_keys
    @attributes.reject { |_k, v| v.blank? }.keys
  end

  def present?
    @attributes.values.flatten.reject(&:blank?).join.present?
  end

  def blank?
    !present?
  end

  alias empty? blank?

  def persisted?
    false
  end

  def apply(_relation)
    message = "ApplicationSearchRecord#apply is abstract & must be implemented by subclasses"
    raise NotImplementedError, message
  end

  def method_missing(name, *args)
    return super unless respond_to?(name)
    if name.to_s.end_with? "="
      @attributes[keyify(name)] = args.first
    else
      @attributes[keyify(name)]
    end
  end

  def respond_to?(name, include_all = false)
    return true if @fields.include?(keyify(name))
    super
  end

  def respond_to_missing?(name, include_all)
    return true if @fields.include?(keyify(name))
    super
  end

  def boolean(value)
    !!(value.to_s =~ /\A1|t(rue)?\z/i)
  end

  private

  def keyify(name)
    name.to_s.sub(/\=\z/, "")
  end
end
