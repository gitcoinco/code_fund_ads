// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
// This controller includes hacks to ensure that jQuery based libs like Select2 work with Turbolinks
import 'select2';
import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    this.create();
    this.element.addEventListener('select:create', this.create.bind(this));
    this.element.addEventListener('select:destroy', this.destroy.bind(this));
    document.addEventListener('turbolinks:before-cache', this.destroy.bind(this));
  }

  create() {
    if (this.created) return;
    jQuery(this.element).select2({
      theme: 'bootstrap',
      closeOnSelect: !this.element.multiple,
    });
    this.element.dispatchEvent(new Event('select:created'));
  }

  destroy() {
    if (this.created) jQuery(this.element).select2('destroy');
    this.element.dispatchEvent(new Event('select:destroyed'));
  }

  get created() {
    return this.element.classList.contains('select2-hidden-accessible');
  }
}
