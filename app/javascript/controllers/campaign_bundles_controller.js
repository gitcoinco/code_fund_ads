import Rails from '@rails/ujs'
import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['activity', 'estimates', 'regions']

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
    this.showActivity()
    this.stimulate(
      'CampaignBundlesReflex#update_region_ids',
      this.selectedRegionIds
    )
  }

  showActivity () {
    this.activityTarget.hidden = false
    this.estimatesTarget.hidden = true
    this.element.querySelectorAll('a,input').forEach(el => (el.disabled = true))
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
