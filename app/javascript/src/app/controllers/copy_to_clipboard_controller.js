import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    jQuery.HSCore.components.HSClipboard.init(this.element);
  }
}
