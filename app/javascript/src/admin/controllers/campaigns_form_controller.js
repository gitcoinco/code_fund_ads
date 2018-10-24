// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import jQuery from 'jquery';
import 'select2';
import { Controller } from 'stimulus';
import { toArray } from '../utils';

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
    this.originalIncludedTopicsSelectOptions = this.includedTopicsSelectOptions;
    this.originalExcludedTopicsSelectOptions = this.excludedTopicsSelectOptions;
    this.originalIncludedProgrammingLanguagesSelectOptions = this.includedProgrammingLanguagesSelectOptions;
    this.originalExcludedProgrammingLanguagesSelectOptions = this.excludedProgrammingLanguagesSelectOptions;
    this.originalCreativeSelectOptions = this.creativeSelectOptions;
    this.initSelect2EventListeners();

    if (this.userSelectTarget.value)
      this.filterCreativeOptions(this.userSelectTarget.value);
  }

  initSelect2EventListeners() {
    $(this.userSelectTarget).on('change.select2', event =>
      this.filterCreativeOptions(event.target.value)
    );
    $(this.creativeSelectTarget).on('change.select2', event => {
      let { userId } = event.target.options[event.target.selectedIndex].dataset;
      this.selectUser(userId);
    });
    $(this.includedTopicsSelectTarget).on(
      'change.select2',
      this.applyTopicExclusions.bind(this)
    );
    $(this.excludedTopicsSelectTarget).on(
      'change.select2',
      this.applyTopicExclusions.bind(this)
    );
    $(this.includedProgrammingLanguagesSelectTarget).on(
      'change.select2',
      this.applyProgrammingLanguageExclusions.bind(this)
    );
    $(this.excludedProgrammingLanguagesSelectTarget).on(
      'change.select2',
      this.applyProgrammingLanguageExclusions.bind(this)
    );
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
      this.originalExcludedTopicsSelectOptions
    );
    this.applyExclusions(
      this.excludedTopicsSelectTarget,
      this.includedTopicsSelectTarget,
      this.originalIncludedTopicsSelectOptions
    );
  }

  applyProgrammingLanguageExclusions() {
    this.applyExclusions(
      this.includedProgrammingLanguagesSelectTarget,
      this.excludedProgrammingLanguagesSelectTarget,
      this.originalExcludedProgrammingLanguagesSelectOptions
    );
    this.applyExclusions(
      this.excludedProgrammingLanguagesSelectTarget,
      this.includedProgrammingLanguagesSelectTarget,
      this.originalIncludedProgrammingLanguagesSelectOptions
    );
  }

  filterCreativeOptions(userId) {
    this.creativeSelectTarget.innerHTML = '';
    this.originalCreativeSelectOptions.forEach(option => {
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

  get includedCountriesSelectOptions() {
    return this.includedSelectTarget.querySelectorAll('option');
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
