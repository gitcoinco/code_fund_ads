class BackLinkComponent < ApplicationComponent
  def initialize(title: nil, link: nil)
    @title = title
    @link = link
  end

  private

  attr_reader :title, :link

  def render?
    title && link
  end
end
