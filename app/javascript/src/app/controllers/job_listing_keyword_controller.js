import { Controller } from 'stimulus'

export default class extends Controller {
  appendToSearch (event) {
    Rails.stopEverything(event)
    let terms = Array.from(
      new Set(
        `${this.inputTarget.value} ${this.element.innerText}`
          .split(' ')
          .map(t => t.toLowerCase())
      )
    )
    this.inputTarget.value = terms.join(' ')
    this.formTarget.submit()
  }

  get inputTarget () {
    return document.getElementById(this.element.dataset.target)
  }

  get formTarget () {
    return this.inputTarget.closest('form')
  }
}
