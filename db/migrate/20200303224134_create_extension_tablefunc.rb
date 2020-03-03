class CreateExtensionTablefunc < ActiveRecord::Migration[6.0]
  def up
    enable_extension :tablefunc
  end

  def down
    disable_extension :tablefunc
  end
end
