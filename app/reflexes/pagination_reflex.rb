class PaginationReflex < ApplicationReflex
  def paginate
    session[:page] = element.dataset[:page].to_i
  end
end
