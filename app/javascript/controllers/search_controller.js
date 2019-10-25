import Rails from '@rails/ujs'
import debounce from 'lodash.debounce'
import ApplicationController from './application_controller'

export default class extends ApplicationController {
  connect () {
    super.connect()
    this.deboucedPerform = debounce(this.perform.bind(this), 250)
  }

  cmdK (event) {
    if (event.metaKey && event.code === 'KeyK') {
      Rails.stopEverything(event)
      this.element.focus()
    }
  }

  hideResults (event) {
    if (event.target.closest('#search-results')) return
    const results = document.getElementById('search-results')
    results.remove()
  }

  perform (event) {
    Rails.stopEverything(event)
    const query = this.element.value.trim()
    if (query.length > 2) this.stimulate('SearchReflex#perform', query)
  }
}
