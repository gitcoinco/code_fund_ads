// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import { Controller } from 'stimulus'
import moment from 'moment'
import events from '../events'

function init (element) {
  jQuery(element).daterangepicker({
    ranges: {
      'Next 30 Days': [moment(), moment().add(29, 'days')],
      'This Month': [moment().startOf('month'), moment().endOf('month')],
      'Last 30 Days': [
        moment().subtract(30, 'days'),
        moment().subtract(1, 'days')
      ],
      'Last Month': [
        moment()
          .subtract(1, 'month')
          .startOf('month'),
        moment()
          .subtract(1, 'month')
          .endOf('month')
      ],
      'Next Month': [
        moment()
          .add(1, 'month')
          .startOf('month'),
        moment()
          .add(1, 'month')
          .endOf('month')
      ]
    }
  })
  jQuery(element).on('apply.daterangepicker', event => {
    event.target.dispatchEvent(events.DateRangeSelectedEvent)
  })
}

document.addEventListener('cable-ready:after-morph', () => {
  document
    .querySelectorAll('[data-controller="select-date-range"]')
    .forEach(el => init(el))
})

export default class extends Controller {
  connect () {
    init(this.element)
  }

  submit () {
    this.element.closest('form').submit()
  }
}
