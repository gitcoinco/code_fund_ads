import { Controller } from 'stimulus'

export default class extends Controller {
  displayModal (event) {
    event.preventDefault()
    event.stopPropagation()

    const url = this.element.dataset.url

    jQuery.get(url, function (html) {
      jQuery('#global-modal').html(html)
      jQuery('#global-modal').modal({ show: true })
    })
  }
}
