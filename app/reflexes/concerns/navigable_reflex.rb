module NavigableReflex
  extend ActiveSupport::Concern

  def set_navigable_variables
    @scoped_by = element.dataset["scoped-by"]
    @sorted_by = element.dataset["sorted-by"]
    @sorted_direction = element.dataset["sorted-direction"]
    @page = element.dataset["page"]
  end
end
