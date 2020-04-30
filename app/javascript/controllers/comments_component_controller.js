import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['container']

  connect () {
    this.element.style.height = `${window.innerHeight -
      this.containerTarget.getBoundingClientRect().top -
      150}px`
  }
}
