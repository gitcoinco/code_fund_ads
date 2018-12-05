// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import { Controller } from 'stimulus';
import moment from 'moment';

export default class extends Controller {
  static targets = ['form', 'datePicker'];

  connect() {
    this.initDatePicker();
  }

  initDatePicker() {
    jQuery(this.datePickerTarget)
      .daterangepicker({
        opens: 'left',
        maxDate: moment(),
        maxSpan: {
          months: 1,
        },
        ranges: {
          'This Week': [moment().startOf('week'), moment()],
          'Last Week': [
            moment()
              .add(-1, 'week')
              .startOf('week'),
            moment()
              .add(-1, 'week')
              .endOf('week'),
          ],
          'This Month': [moment().startOf('month'), moment()],
          'Last Month': [
            moment()
              .add(-1, 'month')
              .startOf('month'),
            moment()
              .add(-1, 'month')
              .endOf('month'),
          ],
        },
      })
      .on(
        'apply.daterangepicker',
        function(ev, picker) {
          this.formTarget.submit();
        }.bind(this)
      );
  }
}
