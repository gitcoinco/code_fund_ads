import { Controller } from 'stimulus'

export default class extends Controller {
  connect () {
    jQuery(this.element).HSMegaMenu({
      event: 'hover',
      pageContainer: jQuery('.container'),
      breakpoint: 767.98,
      hideTimeOut: 0
    })
  }
}
