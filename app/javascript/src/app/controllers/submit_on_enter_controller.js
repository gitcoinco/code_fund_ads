import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['form', 'input'];

  connect() {
    this.inputTarget.addEventListener('keydown', event => {
      if (event.key === 'Enter') {
        this.formTarget.submit();
      }
    });
  }
}
