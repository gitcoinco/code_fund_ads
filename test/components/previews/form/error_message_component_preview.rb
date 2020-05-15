# You can access these previews by visiting:
# http://localhost:3000/rails/view_components/form/error_message_component/TEST_NAME

module Form
  class ErrorMessageComponentPreview < ViewComponent::Preview
    layout "component_preview"

    def default
      object = Campaign.first
      object.errors.add :base, "Error"
      render(Form::ErrorMessageComponent.new(object: object))
    end
  end
end
