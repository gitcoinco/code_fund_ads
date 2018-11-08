// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    jQuery(this.element).flatpickr({
      mode: 'range',
      dateFormat: 'M, d Y',
      minDate: this.defaultStartDate,
      defaultDate: [this.defaultStartDate, this.defaultEndDate],
    });
  }

  get defaultStartDate() {
    return new Date();
  }

  get defaultEndDate() {
    let d = new Date();
    d.setDate(d.getDate() + 30);
    return d;
  }
}
