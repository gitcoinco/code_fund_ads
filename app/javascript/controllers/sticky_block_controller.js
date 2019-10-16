import { Controller } from 'stimulus'

export default class extends Controller {
  connect () {
    jQuery.HSCore.components.HSStickyBlock.init(this.element.className)
  }
}
