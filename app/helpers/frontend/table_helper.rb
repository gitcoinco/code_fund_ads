module Frontend
  module TableHelper
    def table(id: nil, add_class: nil, compact: false, &block)
      table_wrapper do
        content_tag(:table, nil, id: id, class: "table table-striped #{add_class} #{"table-compact" if compact}", &block)
      end
    end

    def paginated_table(id: nil, add_class: nil, &block)
      content_tag(:table, nil, id: id, class: "table table-striped #{add_class}", &block)
    end

    def table_wrapper(&block)
      content_tag(:div, nil, class: "table-responsive", &block)
    end

    def table_head(id: nil, add_class: nil, &block)
      content_tag(:thead, nil, id: id, class: add_class || "thead-light", &block)
    end

    def table_body(id: nil, add_class: nil, &block)
      content_tag(:tbody, nil, id: id, class: add_class, &block)
    end

    def table_row(id: nil, add_class: nil, header: false, &block)
      add_class = "border-bottom #{add_class}" if header

      content_tag(:tr, nil, id: id, class: add_class, &block)
    end

    def table_row_controller(controller, id: nil, add_class: nil, &block)
      content_tag(:tr, nil, id: id, class: add_class, data: {controller: controller}, &block)
    end

    def table_data(id: nil, add_class: nil, add_style: nil, colspan: nil, &block)
      content_tag(:td, nil, id: id, colspan: colspan, class: "align-middle #{add_class}", style: add_style, &block)
    end

    def table_data_value(value, id: nil, add_class: nil)
      content_tag(:td, nil, id: id, class: "align-middle #{add_class}") { value.to_s }
    end

    def table_column(id: nil, add_class: nil, add_style: "", add_scope: nil, &block)
      content_tag(:th, nil, id: id, class: "text-left #{add_class}", style: add_style || "width:10%;", scope: add_scope, &block)
    end

    def pagination_wrapper(id: nil, add_class: nil, &block)
      content_tag(:div, nil, class: "d-flex justify-content-between align-items-center #{add_class}", &block)
    end
  end
end
