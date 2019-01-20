import 'select2';
import { Controller } from 'stimulus';
import { toArray } from '../utils';

export default class extends Controller {
  static targets = ['countryCodeSelect', 'provinceCodeSelect'];

  connect() {
    this.provinces = JSON.parse(this.provinceCodeSelectTarget.dataset.provinces);
    jQuery(this.countryCodeSelectTarget).on('select2:select', this.updateProvinceCodeOptions.bind(this));
    this.updateProvinceCodeOptions();
  }

  updateProvinceCodeOptions(event) {
    this.provinceCodeSelectTarget.innerHTML = '';
    this.createProvinceCodeOptions();
  }

  createProvinceCodeOptions() {
    this.provinceCodeSelectTarget.appendChild(this.createOption(null, ''));
    this.validProvinces.forEach(p => {
      let option = this.createOption(p.id, p.name);
      option.dataset.countryCode = p.countryCode;
      if (this.provinceCodeSelectTarget.dataset.selected === p.id) option.selected = true;
      this.provinceCodeSelectTarget.appendChild(option);
    });
  }

  createOption(value, text) {
    let option = document.createElement('option');
    option.value = value;
    option.text = text;
    return option;
  }

  get selectedCountryCode() {
    return this.countryCodeSelectTarget.value;
  }

  get validProvinces() {
    return this.provinces.filter(p => this.selectedCountryCode === p.countryCode);
  }
}
