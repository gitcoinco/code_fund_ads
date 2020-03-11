module Scopable
  extend ActiveSupport::Concern

  included do
    before_action :set_scoped_by
  end

  def scope_list(model)
    model.public_send @scoped_by
  end

  protected

  def set_scoped_by
    @scoped_by ||= "all"
  end
end
