class ScopableReflex < ApplicationReflex
  def scope
    session[:scope_by] = element.attributes["data-scope-by"]
  end
end
