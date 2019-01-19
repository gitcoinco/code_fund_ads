# == Schema Information
#
# Table name: words
#
#  id          :bigint(8)        not null, primary key
#  record_type :string           not null
#  record_id   :bigint(8)        not null
#  word        :text             not null
#

class Word < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :job_posting, polymorphic: true

  # validations ...............................................................
  validates :word, presence: true

  # callbacks .................................................................

  # scopes ....................................................................
  scope :similar, ->(word, min: 0.5) {
    value = Arel::Nodes::SqlLiteral.new(sanitize_sql_array(["?", word]))
    where Arel::Nodes::NamedFunction.new("similarity", [arel_table[:word], value]).gt(min)
  }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................
end
