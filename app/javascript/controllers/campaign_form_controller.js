import ApplicationController from './application_controller'

export default class extends ApplicationController {
  updateKeywords (event) {
    this.stimulate(
      'CampaignFormReflex#update_keywords',
      [...event.target.selectedOptions].map(option => option.value)
    )
  }

  updateGeoTargeting (event) {
    this.stimulate(
      'CampaignFormReflex#update_geo_targeting',
      [...event.target.selectedOptions].map(option => option.value)
    )
  }
}
