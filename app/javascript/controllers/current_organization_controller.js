import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['form']

  updateCurrentOrganization() {
    this.formTarget.submit()
  }
}
