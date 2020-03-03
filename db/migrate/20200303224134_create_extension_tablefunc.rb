class CreateExtensionTablefunc < ActiveRecord::Migration[6.0]
  def up
    execute "CREATE EXTENSION tablefunc;"
  end
end
