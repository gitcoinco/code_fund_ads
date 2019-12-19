import debounce from 'lodash.debounce'
import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['query', 'activity', 'found']

  connect () {
    super.connect()
    this.perform = debounce(this._perform, 350).bind(this)
  }

  beforePerform () {
    this.activityTarget.hidden = false
    this.foundTarget.hidden = true
  }

  _perform (event) {
    event.preventDefault()
    this.stimulate(
      'OrganizationUsersSearchReflex#perform',
      this.queryTarget.value
    )
  }
}
