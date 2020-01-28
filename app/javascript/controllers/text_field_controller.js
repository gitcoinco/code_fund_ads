import { Controller } from 'stimulus'

export default class extends Controller {
  connect () {
    console.log('dispatching input', this.element)
    this.element.dispatchEvent(new Event('input'))
  }
}
