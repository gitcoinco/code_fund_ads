import { Controller } from 'stimulus'

export default class extends Controller {
  connect () {
    const strings = JSON.parse(this.element.dataset.strings)

    const typeSpeed = parseInt(this.element.dataset.typeSpeed)

    const loop = this.element.dataset.loop === 'true'

    const backSpeed = parseInt(this.element.dataset.backSpeed)

    const backDelay = parseInt(this.element.dataset.backDelay)

    new Typed(this.element, { strings, typeSpeed, loop, backSpeed, backDelay }) // eslint-disable-line no-new
  }
}
