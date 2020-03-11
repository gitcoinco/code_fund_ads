class SortableReflex < ApplicationReflex
  include NavigableReflex

  def sort(sorted_by)
    set_navigable_variables
    @sorted_by = sorted_by
  end

  def flip
    set_navigable_variables
    @sorted_direction = @sorted_direction == "asc" ? "desc" : "asc"
  end
end
