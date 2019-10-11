class CreateAudiences < ActiveRecord::Migration[6.0]
  def change
    create_view :audiences
  end
end
