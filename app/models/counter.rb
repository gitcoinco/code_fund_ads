# == Schema Information
#
# Table name: counters
#
#  id          :bigint(8)        not null, primary key
#  record_id   :bigint(8)        not null
#  record_type :string           not null
#  scope       :string           not null
#  segment     :string
#  count       :bigint(8)        default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Counter < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :record, polymorphic: true

  # validations ...............................................................
  # callbacks .................................................................

  # scopes ....................................................................
  scope :scoped_by, ->(value) { where scope: value }
  scope :segmented_by, ->(value) { where segment: value }
  scope :for_model, ->(model) {
    where(record_type: model.name).where(arel_table[:record_id].eq(model.arel_table[:id]))
  }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end
