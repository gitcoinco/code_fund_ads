// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
// This controller includes hacks to ensure that jQuery based libs like Select2 work with Turbolinks
import jQuery from 'jquery';
import 'select2';
import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    let $element = jQuery(this.element);
    $element.select2({
      theme: 'bootstrap',
      closeOnSelect: !this.element.multiple,
    });

    document.addEventListener('turbolinks:before-cache', () => {
      if ($element.hasClass('select2-hidden-accessible')) {
        $element.select2('destroy');
      }
    });
  }
}
