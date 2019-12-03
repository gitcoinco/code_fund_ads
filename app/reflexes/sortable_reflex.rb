class SortableReflex < ApplicationReflex
  def sort
    session[:sort_by] = element.dataset["sort-name"]
    session[:sort_direction] = element.dataset["direction"]
  end
end
