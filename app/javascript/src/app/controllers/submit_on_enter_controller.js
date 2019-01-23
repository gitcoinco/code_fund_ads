import { Controller } from 'stimulus';
import moment from 'moment';

export default class extends Controller {
  connect() {
    jQuery(this.element).keydown(function(event) {
      const keypressed = event.keyCode || event.which;
      if (keypressed == 13) {
        jQuery(this.element)
          .closest('form')
          .submit();
      }
    });
  }
}
