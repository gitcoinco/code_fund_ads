class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :eventable_id, null: false
      t.string :eventable_type, null: false
      t.string :tags, default: [], array: true
      t.text :body, null: false
      t.integer :user_id, null: false

      t.index :user_id
      t.index [:eventable_id, :eventable_type]

      t.timestamps
    end
  end
end
