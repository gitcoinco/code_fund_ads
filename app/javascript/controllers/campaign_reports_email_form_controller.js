import { Controller } from 'stimulus'

export default class extends Controller {
  success () {
    new window.Noty({
      type: 'success',
      text: this.element.dataset.success
    }).show()
  }

  error () {
    new window.Noty({ type: 'error', text: this.element.dataset.error }).show()
  }
}
