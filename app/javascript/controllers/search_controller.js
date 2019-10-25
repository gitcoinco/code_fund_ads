import Rails from '@rails/ujs'
import debounce from 'lodash.debounce'
import ApplicationController from './application_controller'

export default class extends ApplicationController {
  connect () {
    super.connect()
    this.deboucedPerform = debounce(this.perform.bind(this), 250)
  }

  perform (event) {
    Rails.stopEverything(event)
    this.stimulate('SearchReflex#perform', this.element.value)
  }

  afterPerform () {
    document
      .querySelector('ul#search-results')
      .querySelector('a')
      .setAttribute('tabindex', 0)
  }
}
