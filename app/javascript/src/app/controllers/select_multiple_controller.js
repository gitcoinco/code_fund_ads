import { Controller } from 'stimulus';
import { toArray } from '../utils';

export default class extends Controller {
  static targets = ['select'];

  selectAll(event) {
    Rails.stopEverything(event);
    this.options.forEach(o => (o.selected = true));
    this.selectTarget.dispatchEvent(new Event('change'));
  }

  clearSelections(event) {
    Rails.stopEverything(event);
    this.options.forEach(o => (o.selected = false));
    this.selectTarget.dispatchEvent(new Event('change'));
  }

  get options() {
    return toArray(this.selectTarget.querySelectorAll('option'));
  }
}
