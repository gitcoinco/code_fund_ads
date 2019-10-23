class EveryoneChannel < ApplicationCable::Channel
  def subscribed
    stream_from "everyone"
  end
end
