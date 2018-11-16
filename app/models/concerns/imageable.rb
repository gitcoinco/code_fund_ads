module Imageable
  extend ActiveSupport::Concern

  included do
    has_many_attached :images

    scope :include_image_count, -> do
      attachment_arel_table = ActiveStorage::Attachment.arel_table
      select(arel_table[Arel.star]).
        select(
          attachment_arel_table.
           where(attachment_arel_table[:record_id].eq(arel_table[:id])).
           where(attachment_arel_table[:record_type].eq(name)).
           where(attachment_arel_table[:name].eq("images")).
           project(attachment_arel_table[Arel.star].count).
           as("image_count")
        )
    end
  end

  def imageable_name
    try(:name) || "#{self.class.name}: #{id}"
  end
end
