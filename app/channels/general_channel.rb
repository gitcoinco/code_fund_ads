class GeneralChannel < ApplicationCable::Channel
  def subscribed
    stream_from "general"
  end
end
