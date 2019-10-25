import CableReady from 'cable_ready'
import consumer from './consumer'

consumer.subscriptions.create(
  { channel: 'GeneralChannel', room: 'home#show' },
  {
    received (data) {
      if (data.cableReady) CableReady.perform(data.operations)
    }
  }
)
