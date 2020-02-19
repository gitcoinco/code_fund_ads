// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import { Controller } from 'stimulus'

function init (element) {
  jQuery(element).daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    autoUpdateInput: false
  })
}

document.addEventListener('cable-ready:after-morph', () => {
  document
    .querySelectorAll('[data-controller="select-date"]')
    .forEach(el => init(el))
})

export default class extends Controller {
  connect () {
    init(this.element)
  }
}
