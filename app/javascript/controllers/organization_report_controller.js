import ApplicationController from './application_controller'
import events from '../events'
import { toArray } from '../src/utils'
import moment from 'moment'

export default class extends ApplicationController {
  static targets = ['campaign', 'useSelectedCampaignDates', 'dateRangePicker']

  connect () {
    super.connect()
    this.currentStartDate
    this.currentEndDate
  }

  updateDateRange () {
    this.currentStartDate = moment(
      this.dateRangePickerTarget.dataset.startDate,
      'MM/DD/YYYY'
    ).utc()
    this.currentEndDate = moment(
      this.dateRangePickerTarget.dataset.endDate,
      'MM/DD/YYYY'
    ).utc()

    let newStartDate = this.currentStartDate
    let newEndDate = this.currentEndDate
    let minDate = this.getMinMaxDates().minDate
    let maxDate = this.getMinMaxDates().maxDate

    if (this.useSelectedCampaignDatesTarget.checked) {
      newStartDate = minDate
      newEndDate = maxDate
    }

    jQuery(this.dateRangePickerTarget)
      .data('daterangepicker')
      .setStartDate(newStartDate)
    jQuery(this.dateRangePickerTarget)
      .data('daterangepicker')
      .setEndDate(newEndDate)
  }

  getMinMaxDates () {
    let checkedCampaigns = toArray(
      document.querySelectorAll(
        "[data-target='organization-report.campaign']:checked"
      )
    )
    let minDates = checkedCampaigns.map(obj => new Date(obj.dataset.mindate))
    let maxDates = checkedCampaigns.map(obj => new Date(obj.dataset.maxdate))
    let minDate = new Date(Math.min.apply(null, minDates))
    let maxDate = new Date(Math.max.apply(null, maxDates))

    return {
      minDate: this.dateWithDefault(minDate, this.currentStartDate).utc(),
      maxDate: this.dateWithDefault(maxDate, this.currentEndDate).utc()
    }
  }

  dateWithDefault (d, alt) {
    if (d instanceof Date && !isNaN(d)) {
      return moment(d)
    } else {
      return moment(alt)
    }
  }
}
