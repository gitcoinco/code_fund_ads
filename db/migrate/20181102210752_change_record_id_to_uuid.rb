# frozen_string_literal: true

class ChangeRecordIdToUuid < ActiveRecord::Migration[5.2]
  def up
    execute "truncate table active_storage_attachments;"
    remove_index :active_storage_attachments, name: "index_active_storage_attachments_uniqueness"
    remove_column :active_storage_attachments, :record_id
    add_column :active_storage_attachments, :record_id, :uuid, null: false
    add_index :active_storage_attachments, ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  def down
    execute "truncate table active_storage_attachments;"
    remove_index :active_storage_attachments, name: "index_active_storage_attachments_uniqueness"
    remove_column :active_storage_attachments, :record_id
    add_column :active_storage_attachments, :record_id, :bigint, null: false
    add_index :active_storage_attachments, ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end
end
