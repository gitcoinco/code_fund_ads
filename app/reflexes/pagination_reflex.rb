class PaginationReflex < ApplicationReflex
  def paginate
    session[:current_page] = element.dataset[:page].to_i
  end
end
