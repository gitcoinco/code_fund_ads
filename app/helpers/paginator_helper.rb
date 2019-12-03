module PaginatorHelper
  include Pagy::Frontend

  def pagy_get_params(params)
    params.merge query: @order_by, order_by: @sort_by, direction: @direction
  end
end
