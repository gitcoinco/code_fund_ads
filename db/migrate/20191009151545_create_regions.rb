class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_view :regions
  end
end
