import $ from 'jquery';
import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    $(this.element).select2({
      theme: 'bootstrap',
    });
  }
}
