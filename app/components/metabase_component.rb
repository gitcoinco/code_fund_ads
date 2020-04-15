class MetabaseComponent < ViewComponent::Base
  def initialize(src:, title: "Metabase dashboard", height: 800)
    @src = src
    @title = title
    @height = height
  end

  private

  attr_reader :src, :title, :height
end
