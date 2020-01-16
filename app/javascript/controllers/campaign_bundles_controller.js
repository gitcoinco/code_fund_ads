import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['activity', 'estimates', 'regions']

  beforeUpdateRegionIds () {
    this.activityTarget.hidden = false
    this.estimatesTarget.hidden = true
    this.regionsTarget
      .querySelectorAll('input[type="checkbox"]')
      .forEach(el => (el.disabled = true))
  }
}
