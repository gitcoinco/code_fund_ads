class ChangePaperTrailToUseJsonb < ActiveRecord::Migration[5.2]
  TEXT_BYTES = 1_073_741_823

  def up
    drop_table :versions
    create_table :versions do |t|
      t.string   :item_type, {null: false}
      t.bigint   :item_id, null: false
      t.string   :event, null: false
      t.string   :whodunnit
      t.jsonb    :object
      t.jsonb    :object_changes
      t.datetime :created_at

      t.index [:item_type, :item_id]
      t.index :object, using: :gin
      t.index :object_changes, using: :gin
    end
  end

  def down
    drop_table :versions
    create_table :versions do |t|
      t.string   :item_type, {null: false}
      t.integer  :item_id,   null: false
      t.string   :event,     null: false
      t.string   :whodunnit
      t.text     :object, limit: TEXT_BYTES
      t.datetime :created_at

      t.index [:item_type, :item_id]
    end
  end
end
