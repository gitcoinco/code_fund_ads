import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['input', 'button'];

  select() {
    setTimeout((() => this.inputTarget.select()).bind(this), 10);
  }

  submit() {
    const text = this.buttonTarget.innerText;
    this.buttonTarget.innerText = 'Sending email...';
    setTimeout((() => (this.buttonTarget.innerText = text)).bind(this), 3000);
  }
}
