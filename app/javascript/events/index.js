import newDateRangeSelectedEvent from './date_range_selected_event'
import newValueCommittedEvent from './value_committed_event'

export default {
  get DateRangeSelectedEvent () {
    return newDateRangeSelectedEvent()
  },
  get ValueCommittedEvent () {
    return newValueCommittedEvent()
  }
}
