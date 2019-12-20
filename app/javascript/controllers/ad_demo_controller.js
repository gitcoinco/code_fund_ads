import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['form', 'themeSelect', 'templateSelect']

  connect () {
    // jQuery is required as Select2 uses jQuery events
    jQuery(this.templateSelectTarget).on('change', this.update.bind(this))
    jQuery(this.themeSelectTarget).on('change', this.update.bind(this))
  }

  update () {
    this.formTarget.submit()
  }
}
