class PaginationReflex < ApplicationReflex
  include NavigableReflex

  def paginate
    set_navigable_variables
  end
end
