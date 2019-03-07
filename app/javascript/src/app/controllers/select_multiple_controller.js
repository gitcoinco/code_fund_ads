import { Controller } from 'stimulus';
import { toArray } from '../utils';

export default class extends Controller {
  static targets = ['select'];

  selectAll(event) {
    Rails.stopEverything(event);
    this.options.forEach(o => (o.selected = true));
    this.selectTarget.dispatchEvent(new Event('change'));
    this.selectTarget.dispatchEvent(new Event('cf:select-batch'));
  }

  selectSubset(event) {
    Rails.stopEverything(event);
    let values = JSON.parse(event.target.dataset.values);
    this.options.forEach(o => {
      if (!o.selected) {
        o.selected = values.indexOf(o.value) >= 0;
      }
    });
    this.selectTarget.dispatchEvent(new Event('change'));
    this.selectTarget.dispatchEvent(new Event('cf:select-batch'));
  }

  clearSelections(event) {
    Rails.stopEverything(event);
    this.options.forEach(o => (o.selected = false));
    this.selectTarget.dispatchEvent(new Event('change'));
    this.selectTarget.dispatchEvent(new Event('cf:select-batch'));
  }

  get options() {
    return toArray(this.selectTarget.querySelectorAll('option'));
  }
}
