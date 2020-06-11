class CreatePixels < ActiveRecord::Migration[6.0]
  def change
    create_table :pixels, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name, null: false
      t.text :description
      t.references :organization, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.monetize :value, default: Money.new(0, "USD"), null: false

      t.timestamps
    end
  end
end
