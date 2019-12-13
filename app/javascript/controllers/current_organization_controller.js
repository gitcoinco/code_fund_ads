import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['currentOrganizationForm', 'currentOrganizationSelect']

  connect () {
    // jQuery is required as Select2 uses jQuery events
    jQuery(this.currentOrganizationSelectTarget).on(
      'change',
      this.updateCurrentOrganization.bind(this)
    )
  }

  updateCurrentOrganization () {
    this.currentOrganizationFormTarget.submit()
  }
}
