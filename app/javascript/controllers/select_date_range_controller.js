// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import { Controller } from 'stimulus'
import moment from 'moment'

const init = element => {
  jQuery(element)
    .daterangepicker({
      startDate: element.dataset.startDate,
      endDate: element.dataset.endDate,
      ranges: {
        'Next 30 Days': [moment(), moment().add(29, 'days')],
        'Next 60 Days': [moment(), moment().add(59, 'days')],
        'Next 90 Days': [moment(), moment().add(89, 'days')],
        'This Month': [moment().startOf('month'), moment().endOf('month')],
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
    .on('apply.daterangepicker', () =>
      element.dispatchEvent(new Event('input'))
    )
}

const rewire = () => {
  document
    .querySelectorAll('[data-controller="select-date-range"]')
    .forEach(el => init(el))
}

document.addEventListener('cable-ready:after-morph', rewire)

export default class extends Controller {
  connect () {
    init(this.element)
  }
}
