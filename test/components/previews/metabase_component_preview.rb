# You can access these previews by visiting:
# http://localhost:3000/rails/view_components/metabase_component/TEST_NAME

class MetabaseComponentPreview < ViewComponent::Preview
  layout "component_preview"

  def default
    render(MetabaseComponent.new(src: dashboard_src))
  end

  def tall
    render(MetabaseComponent.new(src: dashboard_src, height: 2000))
  end

  private

  def dashboard_src
    payload = {
      resource: {dashboard: ENV["METABASE_PROPERTY_DASHBOARD_ID"].to_i},
      params: {
        "property_id" => Property.first.id,
        "start_date" => Date.yesterday.strftime("%F"),
        "end_date" => Date.today.strftime("%F")
      }
    }

    ENV["METABASE_SITE_URL"] + "/embed/dashboard/" + JWT.encode(payload, ENV["METABASE_SECRET_KEY"])
  end
end
