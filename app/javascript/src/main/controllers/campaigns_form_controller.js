// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
// This controller includes hacks to ensure that jQuery based libs like Select2 work with Turbolinks
/*import 'select2';*/
//import { Controller } from 'stimulus';
//import { toArray } from '../utils';

//const originals = {};

//export default class extends Controller {
//static targets = [
//'userSelect',
//'creativeSelect',
//'includedCountriesSelect',
//];

//connect() {
//let options = [
//'creativeSelectOptions',
//];
//options.forEach(name => {
//originals[name] = originals[name] || this[name];
//});

//this.initSelect2EventListeners();
//}

//initSelect2EventListeners() {
//jQuery(this.userSelectTarget).on('change.select2', event =>
//this.filterCreativeOptions(event.target.value)
//);
//jQuery(this.creativeSelectTarget).on('change.select2', event => {
//let { userId } = event.target.options[event.target.selectedIndex].dataset;
//this.selectUser(userId);
//});
//}

//selectDevelopedMarketCountries(event) {
//Rails.stopEverything(event);
//this.includedCountriesSelectTarget.querySelectorAll('option').forEach(o => {
//o.selected =
//o.selected || this.developedMarketCountryCodes.indexOf(o.value) >= 0;
//});
//this.triggerChangeEvent(this.includedCountriesSelectTarget);
//}

//selectEmergingMarketCountries(event) {
//Rails.stopEverything(event);
//this.includedCountriesSelectTarget.querySelectorAll('option').forEach(o => {
//o.selected =
//o.selected || this.emergingMarketCountryCodes.indexOf(o.value) >= 0;
//});
//this.triggerChangeEvent(this.includedCountriesSelectTarget);
//}

//selectAllIncludedCountries(event) {
//Rails.stopEverything(event);
//this.includedCountriesSelectTarget
//.querySelectorAll('option')
//.forEach(o => (o.selected = true));
//this.triggerChangeEvent(this.includedCountriesSelectTarget);
//}

//deselectAllIncludedCountries(event) {
//Rails.stopEverything(event);
//this.includedCountriesSelectTarget.value = [];
//this.triggerChangeEvent(this.includedCountriesSelectTarget);
//}

//selectAllIncludedTopics(event) {
//Rails.stopEverything(event);
//this.includedTopicsSelectTarget
//.querySelectorAll('option')
//.forEach(o => (o.selected = true));
//this.triggerChangeEvent(this.includedTopicsSelectTarget);
//}

//deselectAllIncludedTopics(event) {
//Rails.stopEverything(event);
//this.includedTopicsSelectTarget.value = [];
//this.triggerChangeEvent(this.includedTopicsSelectTarget);
//}

//selectAllExcludedTopics(event) {
//Rails.stopEverything(event);
//this.excludedTopicsSelectTarget
//.querySelectorAll('option')
//.forEach(o => (o.selected = true));
//this.triggerChangeEvent(this.excludedTopicsSelectTarget);
//}

//deselectAllExcludedTopics(event) {
//Rails.stopEverything(event);
//this.excludedTopicsSelectTarget.value = [];
//this.triggerChangeEvent(this.excludedTopicsSelectTarget);
//}

//selectAllIncludedProgrammingLanguages(event) {
//Rails.stopEverything(event);
//this.includedProgrammingLanguagesSelectTarget
//.querySelectorAll('option')
//.forEach(o => (o.selected = true));
//this.triggerChangeEvent(this.includedProgrammingLanguagesSelectTarget);
//}

//deselectAllIncludedProgrammingLanguages(event) {
//Rails.stopEverything(event);
//this.includedProgrammingLanguagesSelectTarget.value = [];
//this.triggerChangeEvent(this.includedProgrammingLanguagesSelectTarget);
//}

//selectAllExcludedProgrammingLanguages(event) {
//Rails.stopEverything(event);
//this.excludedProgrammingLanguagesSelectTarget
//.querySelectorAll('option')
//.forEach(o => (o.selected = true));
//this.triggerChangeEvent(this.excludedProgrammingLanguagesSelectTarget);
//}

//deselectAllExcludedProgrammingLanguages(event) {
//Rails.stopEverything(event);
//this.excludedProgrammingLanguagesSelectTarget.value = [];
//this.triggerChangeEvent(this.excludedProgrammingLanguagesSelectTarget);
//}

//filterCreativeOptions(userId) {
//this.creativeSelectTarget.innerHTML = '';
//originals['creativeSelectOptions'].forEach(option => {
//if (!userId || !option.value || option.dataset.userId == userId) {
//this.creativeSelectTarget.appendChild(option);
//}
//});
//}

//selectUser(userId) {
//jQuery(this.userSelectTarget)
//.val(userId)
//.trigger('change');
//}

//triggerChangeEvent(target) {
//target.dispatchEvent(new Event('change'));
//}

//get developedMarketCountryCodes() {
//return this.includedCountriesSelectTarget.dataset.developedMarkets.split(
//','
//);
//}

//get emergingMarketCountryCodes() {
//return this.includedCountriesSelectTarget.dataset.emergingMarkets.split(
//','
//);
//}

//get includedTopicsSelectOptions() {
//return this.includedTopicsSelectTarget.querySelectorAll('option');
//}

//get excludedTopicsSelectOptions() {
//return this.excludedTopicsSelectTarget.querySelectorAll('option');
//}

//get includedProgrammingLanguagesSelectOptions() {
//return this.includedProgrammingLanguagesSelectTarget.querySelectorAll(
//'option'
//);
//}

//get excludedProgrammingLanguagesSelectOptions() {
//return this.excludedProgrammingLanguagesSelectTarget.querySelectorAll(
//'option'
//);
//}

//get creativeSelectOptions() {
//return this.creativeSelectTarget.querySelectorAll('option');
//}
/*}*/
