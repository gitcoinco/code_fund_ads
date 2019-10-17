import { Controller } from 'stimulus'

export default class extends Controller {
  keyPress (event) {
    if (event.key === 'Enter') {
      this.element.submit()
    }
  }
}
