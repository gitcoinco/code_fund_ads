import { Controller } from 'stimulus';
import { toArray } from '../utils';

export default class extends Controller {
  static targets = ['countryCodesSelect', 'provinceCodesSelect'];

  connect() {
    this.provinces = JSON.parse(this.provinceCodesSelectTarget.dataset.provinces);
    this.updateProvinceCodeOptions();
    this.preselectProvinceCodeOptions();
  }

  updateProvinceCodeOptions(event) {
    if (event && event.type === 'keyup' && event.key !== 'Enter') return;

    if (this.validProvinces.length === 0 || this.selectedCountryCodes.length > 30) {
      this.provinceCodesSelectTarget.innerHTML = '';
      this.provinceCodesSelectTarget.disabled = true;
      this.provinceCodesSelectTarget.closest('div[data-controller="select-multiple"]').hidden = true;
      this.provinceCodesSelectTarget.dispatchEvent(new Event('change'));
      return;
    }

    this.provinceCodesSelectTarget.disabled = false;
    this.provinceCodesSelectTarget.closest('div[data-controller="select-multiple"]').hidden = false;
    this.removeInvalidProvinceCodeOptions();
    this.addMissingProvinceCodeOptions();
    this.provinceCodesSelectTarget.dispatchEvent(new Event('change'));
  }

  removeInvalidProvinceCodeOptions() {
    let valid = this.validProvinces;
    this.provinceCodeOptions.forEach(o => {
      let match = valid.find(p => p.countryCode === o.dataset.countryCode);
      if (!match) o.remove();
    });
  }

  addMissingProvinceCodeOptions() {
    let options = this.provinceCodeOptions;
    this.validProvinces.forEach(p => {
      let match = options.find(o => o.dataset.countryCode === p.countryCode);
      if (!match) {
        let option = document.createElement('option');
        option.value = p.id;
        option.text = p.name;
        option.dataset.countryCode = p.countryCode;
        this.provinceCodesSelectTarget.appendChild(option);
      }
    });
  }

  preselectProvinceCodeOptions() {
    this.provinceCodeOptions.forEach(o => {
      if (this.provinceCodesSelectTarget.dataset.selected.indexOf(o.value) > 0) o.selected = true;
    });
  }

  get selectedCountryCodes() {
    return toArray(this.countryCodesSelectTarget.querySelectorAll('option:checked')).map(o => o.value);
  }

  get provinceCodeOptions() {
    return toArray(this.provinceCodesSelectTarget.querySelectorAll('option'));
  }

  get validProvinces() {
    return this.provinces.filter(p => this.selectedCountryCodes.find(c => c === p.countryCode));
  }

  //selectDevelopedMarkets(event) {
  //  Rails.stopEverything(event);
  //  developedMarkets.forEach(val => {
  //    let option = this.options.find(o => o.value === val);
  //    if (option) option.selected = true;
  //  });
  //  this.selectTarget.dispatchEvent(new Event('change'));
  //}
  //selectEmergingMarkets(event) {
  //  Rails.stopEverything(event);
  //  emergingMarkets.forEach(val => {
  //    let option = this.options.find(o => o.value === val);
  //    if (option) option.selected = true;
  //  });
  //  this.selectTarget.dispatchEvent(new Event('change'));
  //}
}
