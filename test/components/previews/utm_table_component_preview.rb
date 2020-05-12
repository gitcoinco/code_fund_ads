# You can access these previews by visiting:
# http://localhost:3000/rails/view_components/utm_table_component/TEST_NAME

class UtmTableComponentPreview < ViewComponent::Preview
  layout "component_preview"

  def default
    render(UtmTableComponent.new(campaign: Campaign.first))
  end
end
