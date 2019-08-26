import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['input'];

  copy(event) {
    Rails.stopEverything(event);
    const value = this.inputTarget.value;
    this.inputTarget.select();
    document.execCommand('copy');
    this.inputTarget.selectionStart = this.inputTarget.selectionEnd;
    this.inputTarget.value = 'Copied...';
    setTimeout((() => (this.inputTarget.value = value)).bind(this), 1000);
  }
}
