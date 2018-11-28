class CreateCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :counters do |t|
      t.bigint :record_id, null: false
      t.string :record_type, null: false
      t.string :scope, null: false
      t.string :segment
      t.bigint :count, null: false, default: 0
      t.timestamps

      t.index [:record_type, :record_id, :scope]
      t.index [:record_type, :record_id, :scope, :segment], unique: true, name: "index_counters_on_record_and_scope_and_segment"
    end
  end
end
