class CreateEmailTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :email_templates do |t|
      t.string :title, null: false
      t.string :subject, null: false
      t.string :body, null: false

      t.timestamps
    end
  end
end
