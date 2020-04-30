# You can access these previews by visiting:
# http://localhost:3000/rails/view_components/page_component/TEST_NAME

class PageComponentPreview < ViewComponent::Preview
  layout "component_preview"

  def default
    render(PageComponent.new) do |component|
      component.with(:header) do
        tag.img(src: "https://via.placeholder.com/500x100?text=Header")
      end
      component.with(:body) do
        tag.img src: "https://via.placeholder.com/500x750?text=Body"
      end
    end
  end
end
