import Rails from '@rails/ujs'
import { Controller } from 'stimulus'
import { toArray } from '../src/utils'

export default class extends Controller {
  static targets = ['select']

  selectAll (event) {
    Rails.stopEverything(event)
    this.options.forEach(o => (o.selected = true))
    this.selectTarget.dispatchEvent(new Event('change'))
  }

  selectSubset (event) {
    Rails.stopEverything(event)
    const values = JSON.parse(event.target.dataset.values)
    this.options.forEach(o => {
      if (!o.selected) {
        o.selected = values.indexOf(o.value) >= 0
      }
    })
    this.selectTarget.dispatchEvent(new Event('change'))
  }

  clearSelections (event) {
    Rails.stopEverything(event)
    this.options.forEach(o => (o.selected = false))
    this.selectTarget.dispatchEvent(new Event('change'))
  }

  get options () {
    return toArray(this.selectTarget.querySelectorAll('option'))
  }
}
