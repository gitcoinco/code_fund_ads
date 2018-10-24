// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import jQuery from 'jquery';
import 'select2';
import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['userSelect', 'creativeSelect'];

  connect() {
    this.userSelectOptions = this.userSelectTarget.querySelectorAll('option');
    this.creativeSelectOptions = this.creativeSelectTarget.querySelectorAll(
      'option'
    );
    jQuery(this.userSelectTarget).on('change.select2', event => {
      this.filterCreativeOptions(event.target.value);
    });
    jQuery(this.creativeSelectTarget).on('change.select2', event => {
      let { userId } = event.target.options[event.target.selectedIndex].dataset;
      this.selectUser(userId);
    });
  }

  filterCreativeOptions(userId) {
    this.creativeSelectTarget.innerHTML = '';
    this.creativeSelectOptions.forEach(option => {
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
}
