import { Controller } from 'stimulus'
import consumer from '../channels/consumer'

export default class extends Controller {
  connect () {
    this.show = (() => {
      if (consumer.connection.isOpen()) this.element.hidden = false
    }).bind(this)
    this.hide = (() => (this.element.hidden = true)).bind(this)
    document.addEventListener('stimulus-reflex:before', this.show)
    document.addEventListener('stimulus-reflex:after', this.hide)
  }

  disconnect () {
    document.removeEventListener('stimulus-reflex:before', this.show)
    document.removeEventListener('stimulus-reflex:after', this.hide)
  }
}
