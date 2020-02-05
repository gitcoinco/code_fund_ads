import ApplicationController from './application_controller'

export default class extends ApplicationController {
  updateKeywords (event) {
    this.stimulate('PropertyFormReflex#update_keywords', event.target.value)
  }
}
