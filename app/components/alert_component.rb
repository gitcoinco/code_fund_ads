class AlertComponent < ApplicationComponent
  def initialize(variant: nil, icon: nil, dismissible: true, cta: nil, heading: nil, body: nil)
    @variant = variant
    @icon = icon
    @dismissible = dismissible
    @cta = cta
    @heading = heading
    @body = body
  end

  private

  attr_reader :variant, :icon, :dismissible, :cta, :heading, :body

  def classes
    classes = ["alert mb-2 d-flex align-items-center justify-content-between alert-#{valid_variant(variant)}"]
    classes << "has-icon" if icon
    classes << "alert-dismissible fade show" if dismissible
    classes.compact
  end
end
