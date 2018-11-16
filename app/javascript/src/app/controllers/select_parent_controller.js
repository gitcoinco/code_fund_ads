import 'select2';
import { Controller } from 'stimulus';
import { toArray } from '../utils';

export default class extends Controller {
  connect() {
    this.saveOrigChildOptionsState();

    this.changeHandler = this.filterChildren.bind(this);
    this.beforeCacheHandler = (() => {
      this.restoreOrigChildOptionsState();
      jQuery(this.element).off('change.select2', this.changeHandler);
    }).bind(this);

    document.addEventListener('turbolinks:before-cache', this.beforeCacheHandler);
    jQuery(this.element).on('change.select2', this.changeHandler);
    if (this.element.value) this.filterChildren();
  }

  filterChildren() {
    if (!this.childSelectTarget) return;
    this.childSelectTarget.dispatchEvent(new Event('select:destroy'));
    this.restoreOrigChildOptionsState();
    if (this.element.value) {
      this.childOptions.forEach(option => {
        if (option.dataset.parentId !== this.element.value) {
          option.hidden = true;
          option.disabled = true;
          option.selected = false;
        }
      });
    }
    if (this.element.triggeringChildOption) {
      this.element.triggeringChildOption.hidden = false;
      this.element.triggeringChildOption.disabled = false;
      this.element.triggeringChildOption.selected = true;
    }
    this.childSelectTarget.dispatchEvent(new Event('select:create'));
  }

  saveOrigChildOptionsState() {
    this.childOptions.forEach(option => {
      option.dataset.origHidden = option.hidden;
      option.dataset.origDisabled = option.disabled;
      option.dataset.origSelected = option.selected;
    });
  }

  restoreOrigChildOptionsState(callback) {
    this.childOptions.forEach(option => {
      option.hidden = option.dataset.origHidden === 'true';
      option.disabled = option.dataset.origDisabled === 'true';
      option.selected = option.dataset.origSelected === 'true';
    });
  }

  get childSelectTarget() {
    let id = this.element.dataset.child;
    let element = document.getElementById(id);
    if (!element) console.log(`select-parent-controller: Unable to find a child with the id '${id}'`);
    return element;
  }

  get childOptions() {
    if (!this.childSelectTarget) return [];
    return toArray(this.childSelectTarget.querySelectorAll('option'));
  }
}
