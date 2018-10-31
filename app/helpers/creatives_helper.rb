# frozen_string_literal: true

module CreativesHelper
  def creative_assets_html(creative)
    html = []
    html << tag.span("small", class: "badge badge-light") if creative.small_image_asset_id
    html << tag.span("large", class: "badge badge-light") if creative.large_image_asset_id
    html << tag.span("wide", class: "badge badge-light") if creative.wide_image_asset_id
    html.join.html_safe
  end
end
