# frozen_string_literal: true

Rails.application.config.ad_templates = Dir[Rails.root.join("app/javascript/advertisements/**")].each_with_object({}) { |path, memo|
  if File.directory?(path)
    name = path.split("/").last
    template = File.read(File.join(path, "template.html.mustache"), encoding: "UTF-8").squish
    memo[name] = template.freeze
  end
}.freeze
