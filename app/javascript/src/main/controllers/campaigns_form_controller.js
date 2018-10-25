// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
// This controller includes hacks to ensure that jQuery based libs like Select2 work with Turbolinks
import 'select2';
import { Controller } from 'stimulus';
import { toArray } from '../utils';

const originals = {};

export default class extends Controller {
  static targets = [
    'userSelect',
    'creativeSelect',
    'includedCountriesSelect',
    'includedTopicsSelect',
    'excludedTopicsSelect',
    'includedProgrammingLanguagesSelect',
    'excludedProgrammingLanguagesSelect',
  ];

  connect() {
    let options = [
      'includedTopicsSelectOptions',
      'excludedTopicsSelectOptions',
      'includedProgrammingLanguagesSelectOptions',
      'excludedProgrammingLanguagesSelectOptions',
      'creativeSelectOptions',
    ];
    options.forEach(name => {
      originals[name] = originals[name] || this[name];
      this.setOptions(name);
    });

    this.initSelect2EventListeners();

    if (this.userSelectTarget.value)
      this.filterCreativeOptions(this.userSelectTarget.value);

    if (this.creativeSelectTarget.value)
      this.selectUser(
        this.creativeSelectTarget.options[
          this.creativeSelectTarget.selectedIndex
        ].dataset.userId
      );
  }

  initSelect2EventListeners() {
    jQuery(this.userSelectTarget).on('change.select2', event =>
      this.filterCreativeOptions(event.target.value)
    );
    jQuery(this.creativeSelectTarget).on('change.select2', event => {
      let { userId } = event.target.options[event.target.selectedIndex].dataset;
      this.selectUser(userId);
    });
    jQuery(this.includedTopicsSelectTarget).on(
      'change.select2',
      this.applyTopicExclusions.bind(this)
    );
    jQuery(this.excludedTopicsSelectTarget).on(
      'change.select2',
      this.applyTopicExclusions.bind(this)
    );
    jQuery(this.includedProgrammingLanguagesSelectTarget).on(
      'change.select2',
      this.applyProgrammingLanguageExclusions.bind(this)
    );
    jQuery(this.excludedProgrammingLanguagesSelectTarget).on(
      'change.select2',
      this.applyProgrammingLanguageExclusions.bind(this)
    );
  }

  selectDevelopedMarketCountries(event) {
    Rails.stopEverything(event);
    this.includedCountriesSelectTarget.querySelectorAll('option').forEach(o => {
      o.selected =
        o.selected || this.developedMarketCountryCodes.indexOf(o.value) >= 0;
    });
    this.triggerChangeEvent(this.includedCountriesSelectTarget);
  }

  selectEmergingMarketCountries(event) {
    Rails.stopEverything(event);
    this.includedCountriesSelectTarget.querySelectorAll('option').forEach(o => {
      o.selected =
        o.selected || this.emergingMarketCountryCodes.indexOf(o.value) >= 0;
    });
    this.triggerChangeEvent(this.includedCountriesSelectTarget);
  }

  selectAllIncludedCountries(event) {
    Rails.stopEverything(event);
    this.includedCountriesSelectTarget
      .querySelectorAll('option')
      .forEach(o => (o.selected = true));
    this.triggerChangeEvent(this.includedCountriesSelectTarget);
  }

  deselectAllIncludedCountries(event) {
    Rails.stopEverything(event);
    this.includedCountriesSelectTarget.value = [];
    this.triggerChangeEvent(this.includedCountriesSelectTarget);
  }

  selectAllIncludedTopics(event) {
    Rails.stopEverything(event);
    this.includedTopicsSelectTarget
      .querySelectorAll('option')
      .forEach(o => (o.selected = true));
    this.triggerChangeEvent(this.includedTopicsSelectTarget);
  }

  deselectAllIncludedTopics(event) {
    Rails.stopEverything(event);
    this.includedTopicsSelectTarget.value = [];
    this.triggerChangeEvent(this.includedTopicsSelectTarget);
  }

  selectAllExcludedTopics(event) {
    Rails.stopEverything(event);
    this.excludedTopicsSelectTarget
      .querySelectorAll('option')
      .forEach(o => (o.selected = true));
    this.triggerChangeEvent(this.excludedTopicsSelectTarget);
  }

  deselectAllExcludedTopics(event) {
    Rails.stopEverything(event);
    this.excludedTopicsSelectTarget.value = [];
    this.triggerChangeEvent(this.excludedTopicsSelectTarget);
  }

  selectAllIncludedProgrammingLanguages(event) {
    Rails.stopEverything(event);
    this.includedProgrammingLanguagesSelectTarget
      .querySelectorAll('option')
      .forEach(o => (o.selected = true));
    this.triggerChangeEvent(this.includedProgrammingLanguagesSelectTarget);
  }

  deselectAllIncludedProgrammingLanguages(event) {
    Rails.stopEverything(event);
    this.includedProgrammingLanguagesSelectTarget.value = [];
    this.triggerChangeEvent(this.includedProgrammingLanguagesSelectTarget);
  }

  selectAllExcludedProgrammingLanguages(event) {
    Rails.stopEverything(event);
    this.excludedProgrammingLanguagesSelectTarget
      .querySelectorAll('option')
      .forEach(o => (o.selected = true));
    this.triggerChangeEvent(this.excludedProgrammingLanguagesSelectTarget);
  }

  deselectAllExcludedProgrammingLanguages(event) {
    Rails.stopEverything(event);
    this.excludedProgrammingLanguagesSelectTarget.value = [];
    this.triggerChangeEvent(this.excludedProgrammingLanguagesSelectTarget);
  }

  applyTopicExclusions() {
    this.applyExclusions(
      this.includedTopicsSelectTarget,
      this.excludedTopicsSelectTarget,
      originals['excludedTopicsSelectOptions']
    );
    this.applyExclusions(
      this.excludedTopicsSelectTarget,
      this.includedTopicsSelectTarget,
      originals['includedTopicsSelectOptions']
    );
  }

  applyProgrammingLanguageExclusions() {
    this.applyExclusions(
      this.includedProgrammingLanguagesSelectTarget,
      this.excludedProgrammingLanguagesSelectTarget,
      originals['excludedProgrammingLanguagesSelectOptions']
    );
    this.applyExclusions(
      this.excludedProgrammingLanguagesSelectTarget,
      this.includedProgrammingLanguagesSelectTarget,
      originals['includedProgrammingLanguagesSelectOptions']
    );
  }

  filterCreativeOptions(userId) {
    this.creativeSelectTarget.innerHTML = '';
    originals['creativeSelectOptions'].forEach(option => {
      if (!userId || !option.value || option.dataset.userId == userId) {
        this.creativeSelectTarget.appendChild(option);
      }
    });
  }

  selectUser(userId) {
    jQuery(this.userSelectTarget)
      .val(userId)
      .trigger('change');
  }

  triggerChangeEvent(target) {
    target.dispatchEvent(new Event('change'));
  }

  applyExclusions(a, b, bOptions) {
    if (this.applyingExclusions) return;
    this.applyingExclusions = true;

    a.querySelectorAll('option').forEach(aOption => {
      let bOption = toArray(bOptions).find(o => o.value === aOption.value);
      if (aOption.selected) {
        if (bOption && bOption.parentNode === b) b.removeChild(bOption);
      } else {
        if (bOption && bOption.parentNode !== b) b.appendChild(bOption);
      }
    }, this);

    bOptions = toArray(b.querySelectorAll('option')).sort((y, z) => {
      if (y.value < z.value) return -1;
      if (y.value > z.value) return 1;
      return 0;
    });
    b.innerHTML = '';
    bOptions.forEach(o => b.appendChild(o));
    this.triggerChangeEvent(b);
    this.applyingExclusions = false;
  }

  setOptions(name) {
    let targetName = name.replace('Options', 'Target');
    let target = this[targetName];
    let originalOptions = originals[name];
    target.innerHTML = '';
    originalOptions.forEach(option => target.appendChild(option));
  }

  get developedMarketCountryCodes() {
    return this.includedCountriesSelectTarget.dataset.developedMarkets.split(
      ','
    );
  }

  get emergingMarketCountryCodes() {
    return this.includedCountriesSelectTarget.dataset.emergingMarkets.split(
      ','
    );
  }

  get includedTopicsSelectOptions() {
    return this.includedTopicsSelectTarget.querySelectorAll('option');
  }

  get excludedTopicsSelectOptions() {
    return this.excludedTopicsSelectTarget.querySelectorAll('option');
  }

  get includedProgrammingLanguagesSelectOptions() {
    return this.includedProgrammingLanguagesSelectTarget.querySelectorAll(
      'option'
    );
  }

  get excludedProgrammingLanguagesSelectOptions() {
    return this.excludedProgrammingLanguagesSelectTarget.querySelectorAll(
      'option'
    );
  }

  get creativeSelectOptions() {
    return this.creativeSelectTarget.querySelectorAll('option');
  }
}
