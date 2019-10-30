import Rails from '@rails/ujs'
import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['input']

  copy (event) {
    Rails.stopEverything(event)
    const value = this.inputTarget.value
    const disabled = !!this.inputTarget.disabled
    this.inputTarget.removeAttribute('disabled')
    this.inputTarget.disabled = false
    this.inputTarget.select()
    document.execCommand('copy')
    this.inputTarget.value = 'Copied...'
    setTimeout(
      (() => {
        this.inputTarget.selectionStart = this.inputTarget.selectionEnd
        if (disabled) this.inputTarget.setAttribute('disabled', disabled)
        this.inputTarget.disabled = disabled
      }).bind(this),
      10
    )
    setTimeout((() => (this.inputTarget.value = value)).bind(this), 1000)
  }
}
