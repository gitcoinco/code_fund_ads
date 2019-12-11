import Rails from '@rails/ujs'
import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['form', 'creativesWrapper', 'advertiserSelectField']

  connect () {
    // jQuery is required as Select2 uses jQuery events
    jQuery(this.advertiserSelectFieldTarget).on(
      'change',
      this.updateCreativeOptions.bind(this)
    )
  }

  updateCreativeOptions (event) {
    const selectedIds = this.formTarget.dataset.selectedCreativeIds
    const advertiserId = this.advertiserSelectFieldTarget.value
    const partialUrl = `/creative_options?user_id=${advertiserId}&selected_ids=${selectedIds}`
    fetch(partialUrl, {
      method: 'GET',
      dataType: 'html',
      credentials: 'same-origin',
      headers: { 'X-CSRF_Token': Rails.csrfToken() }
    })
      .then(
        (response => {
          return response.text()
        }).bind(this)
      )
      .then(
        (html => {
          this.setCreativeOptions(html)
        }).bind(this)
      )
      .catch(function (error) {
        console.log(error)
      })
  }

  setCreativeOptions (html) {
    this.creativesWrapperTarget.innerHTML = html
  }
}
