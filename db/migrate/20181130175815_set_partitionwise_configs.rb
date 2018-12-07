class SetPartitionwiseConfigs < ActiveRecord::Migration[5.2]
  # disable_ddl_transaction!

  def up
    # Disabled until Heroku supports this
    # execute "ALTER SYSTEM SET enable_partitionwise_join=on;"
    # execute "ALTER SYSTEM SET enable_partitionwise_aggregate=on;"
  end

  def down
    # Disabled until Heroku supports this
    # execute "ALTER SYSTEM RESET enable_partitionwise_join;"
    # execute "ALTER SYSTEM RESET enable_partitionwise_aggregate;"
  end
end
