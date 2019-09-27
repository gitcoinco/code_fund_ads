import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['remoteCountryCodesSelector']

  toggleRemote (event) {
    this.remoteCountryCodesSelectorTarget.hidden = !event.target.checked
  }
}
