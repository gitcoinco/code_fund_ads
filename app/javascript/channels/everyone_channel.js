import CableReady from 'cable_ready'
import consumer from './consumer'

consumer.subscriptions.create('EveryoneChannel', {
  connected () {
    console.log('everyone', 'connected')
  },

  disconnected () {
    console.log('everyone', 'disconnected')
  },

  received (data) {
    console.log('everyone', 'received', data)
    if (data.cableReady) CableReady.perform(data.operations)
  }
})
