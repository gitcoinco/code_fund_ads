// Used to make sure `PageComponent` is the full height of the browser
// and takes zoom percentage in to account.
import { Controller } from 'stimulus'

export default class extends Controller {
  connect () {
    this.element.style.minHeight = `${window.innerHeight}px`
  }
}
