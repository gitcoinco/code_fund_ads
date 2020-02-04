// Bootstrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
// This controller includes hacks to ensure that jQuery based libs like Select2 work with Turbolinks
import 'select2'
import { Controller } from 'stimulus'

function create (element) {
  const created = element.classList.contains('select2-hidden-accessible')
  if (created) return

  jQuery(element).select2({
    theme: 'bootstrap',
    width: '100%',
    closeOnSelect: !element.multiple
  })
  element.dispatchEvent(new Event('select:created'))
  jQuery(element).on(
    'change.select2',
    (() =>
      element.dispatchEvent(
        new Event('cf:select:changed', { bubbles: true })
      )).bind(this)
  )
}

function destroy (element) {
  const created = element.classList.contains('select2-hidden-accessible')
  if (created) jQuery(element).select2('destroy')
  element.dispatchEvent(new Event('select:destroyed'))
}

document.addEventListener('cable-ready:before-morph', () => {
  document
    .querySelectorAll('[data-controller="select"]')
    .forEach(element => destroy(element))
})

document.addEventListener('cable-ready:after-morph', () => {
  document
    .querySelectorAll('[data-controller="select"]')
    .forEach(element => create(element))
})

export default class extends Controller {
  connect () {
    create(this.element)

    this.element.addEventListener('select:create', () => {
      create(this.element)
    })

    this.element.addEventListener('select:destroy', () => {
      destroy(this.element)
    })

    document.addEventListener('turbolinks:before-cache', () => {
      destroy(this.element)
    })
  }
}
