module Colorable
  extend ActiveSupport::Concern

  def bg_color
    "##{Digest::MD5.hexdigest(id.to_s)[0, 6]}".paint
  end

  def text_color
    bg_color.dark? ? "#ffffff".paint : "#000000".paint
  end
end
