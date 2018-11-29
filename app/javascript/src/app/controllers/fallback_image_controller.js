import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    const $target = jQuery(this.element);
    $target.on("error", () => {
      $target.attr('src', $target.data('fallback-image-url'));
    });
  }
}
