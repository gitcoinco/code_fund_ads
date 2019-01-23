import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['form', 'input'];

  connect() {
    this.inputTarget.addEventListener('keydown', event => {
      const keypressed = event.keyCode || event.which;
      if (keypressed == 13) {
        this.formTarget.submit();
      }
    });
  }
}
