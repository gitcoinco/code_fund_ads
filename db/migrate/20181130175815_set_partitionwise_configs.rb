class SetPartitionwiseConfigs < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def up
    execute "SET enable_partitionwise_join=on;"
    execute "SET enable_partitionwise_aggregate=on;"
  end

  def down
    execute "RESET enable_partitionwise_join;"
    execute "RESET enable_partitionwise_aggregate;"
  end
end
