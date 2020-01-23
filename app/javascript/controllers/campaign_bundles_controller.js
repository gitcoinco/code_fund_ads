import Rails from '@rails/ujs'
import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['regions']

  selectAllRegionIds (event) {
    Rails.stopEverything(event)
    this.setAllRegionIds(true)
  }

  deselectAllRegionIds (event) {
    Rails.stopEverything(event)
    this.setAllRegionIds(false)
  }

  setAllRegionIds (checked) {
    this.regionCheckboxes.forEach(el => {
      el.removeAttribute('action')
      el.checked = checked
    })
    this.updateSelectedRegionIds()
  }

  updateSelectedRegionIds () {
    this.stimulate(
      'CampaignBundlesReflex#update_region_ids',
      this.selectedRegionIds
    )
  }

  get regionCheckboxes () {
    return Array.from(
      this.regionsTarget.querySelectorAll('input[type="checkbox"]')
    )
  }

  get selectedRegionIds () {
    return this.regionCheckboxes.reduce((memo, checkbox) => {
      if (checkbox.checked) memo.push(checkbox.value)
      return memo
    }, [])
  }
}
