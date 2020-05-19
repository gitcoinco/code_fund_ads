class Emails::BodyComponent < ApplicationComponent
  def initialize(body: nil)
    @body = body
  end

  private

  attr_reader :body

  def render?
    body.present?
  end
end
