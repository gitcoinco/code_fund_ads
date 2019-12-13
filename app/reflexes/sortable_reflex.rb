class SortableReflex < ApplicationReflex
  def sort(sort_by)
    session[:sort_by] = sort_by
    session[:sort_direction] = session[:last_sort_by] == sort_by ? flip_direction : "asc"
  end

  def flip
    session[:sort_direction] = flip_direction
  end

  private

  def flip_direction
    (session[:sort_direction] || "asc")&.inquiry&.asc? ? "desc" : "asc"
  end
end
