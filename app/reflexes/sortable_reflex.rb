class SortableReflex < ApplicationReflex
  def sort
    session[:sort_by] = element.attributes["data-column-name"]
    session[:sort_direction] = element.attributes["data-direction"]
  end
end
