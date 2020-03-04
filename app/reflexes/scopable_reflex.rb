class ScopableReflex < ApplicationReflex
  def scope
    session[:scope_by] = element.dataset["scope-by"]
  end
end
