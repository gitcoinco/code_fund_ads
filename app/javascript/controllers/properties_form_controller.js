import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['keywordsSelector']

  beforeReflex () {}

  updateKeywords (event) {
    this.stimulate('PropertiesFormReflex#update_keywords', event.target.value)
  }
}
