import attempt from 'lodash.attempt'
import debounce from 'lodash.debounce'
import ApplicationController from './application_controller'

export default class extends ApplicationController {
  connect () {
    super.connect()
    this.deboucedPerform = debounce(this.perform.bind(this), 250)
  }

  cmdK (event) {
    if (event.metaKey && event.code === 'KeyK') this.element.focus()
  }

  hideResults (event) {
    if (event.type === 'keyup' && event.key !== 'Escape') return
    if (event.type === 'click' && event.target.closest('#search-results'))
      return
    attempt(() => this.searchResultsTarget.remove())
  }

  perform (event) {
    const query = this.element.value.trim()
    if (query.length > 2) this.stimulate('SearchReflex#perform', query)
  }

  get searchResultsTarget () {
    return document.getElementById('search-results')
  }
}
