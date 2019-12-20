class AdDemoReflex < ApplicationReflex
  def update
    @template = element[:value] if element[:name].inquiry.template?
    @theme = element[:value] if element[:name].inquiry.theme?
  end
end
