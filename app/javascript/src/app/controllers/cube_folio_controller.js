import { Controller } from 'stimulus'

export default class extends Controller {
  connect () {
    jQuery.HSCore.components.HSCubeportfolio.init(this.element)
  }
}
