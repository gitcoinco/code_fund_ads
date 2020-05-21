module Frontend
  module TableHelper
    def table_wrapper(&block)
      content_tag(:div, nil, class: "table-responsive", &block)
    end

    def table(add_class: nil, &block)
      table_wrapper do
        content_tag(:table, nil, class: "table table-hover #{add_class}", &block)
      end
    end

    def paginated_table(add_class: nil, &block)
      content_tag(:table, nil, class: "table table-hover #{add_class}", &block)
    end

    def table_head(add_class: nil, bg_color: "", &block)
      content_tag(:thead, nil, class: "#{bg_color} #{add_class}", &block)
    end

    def table_body(add_class: nil, data: nil, &block)
      content_tag(:tbody, nil, class: add_class, data: data, &block)
    end

    def table_footer(add_class: nil, &block)
      content_tag(:tfoot, nil, class: add_class, &block)
    end

    def table_row(add_class: nil, header: false, title: nil, &block)
      add_class = "border-bottom #{add_class}" if header

      content_tag(:tr, nil, class: add_class, title: title, &block)
    end

    def table_row_controller(controller, add_class: nil, &block)
      content_tag(:tr, nil, class: add_class, data: {controller: controller}, &block)
    end

    def table_data(value = nil, add_class: nil, add_style: nil, colspan: nil, data: nil, title: nil, &block)
      content_tag(:td, value, colspan: colspan, data: data, title: title, class: "align-middle #{add_class}", style: add_style, &block)
    end

    def table_column(value = nil, add_class: nil, add_style: nil, colspan: nil, &block)
      content_tag(:th, value, colspan: colspan, class: "text-left #{add_class}", style: add_style || "width:auto;", scope: "col", &block)
    end

    def pagination_wrapper(add_class: nil, &block)
      content_tag(:div, nil, class: "bg-light d-flex justify-content-between align-items-center pl-1 pr-4 py-2 #{add_class}", &block)
    end

    def sortable_tr(column, title = nil, add_style: nil, add_class: nil)
      title ||= column.titleize
      direction = column == @sorted_by && @sorted_direction == "asc" ? "desc" : "asc"
      selected = nil

      if @sorted_by == column
        selected = if direction == "desc"
          "up"
        else
          "down"
        end
      end
      render "/shared/sortable_tr", title: title, selected: selected, column: column, add_style: add_style, add_class: add_class
    end
  end
end
