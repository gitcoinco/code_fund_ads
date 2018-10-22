# frozen_string_literal: true

module ApplicationHelper
  def skippy(&block)
    render "/@shared/skippy", &block
  end

  def header(&block)
    render "/@shared/header", &block
  end

  def navbar(&block)
    render "/@shared/navbar", &block
  end

  def footer(&block)
    render "/@shared/footer", &block
  end

  def breadcrumbs
    @breadcrumbs = yield
  end
end
