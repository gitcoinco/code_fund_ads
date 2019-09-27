import { Controller } from 'stimulus'
// import Rails from 'rails-ujs';
import { Binding } from '@stimulus/core/dist/src/binding'

export default class extends Controller {
  static targets = [
    'form',
    'creativesWrapper',
    'advertiserSelectField',
    'sponsorForm',
    'standardForm'
  ]

  connect () {
    // jQuery is required as Select2 uses jQuery events
    jQuery(this.advertiserSelectFieldTarget).on(
      'change',
      this.updateCreativeOptions.bind(this)
    )
    this.standardFormFields = this.standardFormTarget.querySelector(
      '#standard-form-fields'
    )
    this.sponsorFormFields = this.sponsorFormTarget.querySelector(
      '#sponsor-form-fields'
    )

    this.standardFormTarget.classList.contains('active')
      ? this.enableStandardForm()
      : this.enableSponsorForm()
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

  enableStandardForm (event) {
    if (event) Rails.stopEverything(event)
    this.sponsorFormFields.remove()
    this.standardFormTarget.appendChild(this.standardFormFields)
  }

  enableSponsorForm (event) {
    if (event) Rails.stopEverything(event)
    this.standardFormFields.remove()
    this.sponsorFormTarget.appendChild(this.sponsorFormFields)
  }
}
