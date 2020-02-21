class AddPropertyTypeDefaultToProperties < ActiveRecord::Migration[6.0]
  change_column_default(:properties, :property_type, from: nil, to: ENUMS::PROPERTY_TYPES::WEBSITE)
end
