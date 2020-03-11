class ScopableReflex < ApplicationReflex
  include NavigableReflex

  def scope
    set_navigable_variables
  end
end
