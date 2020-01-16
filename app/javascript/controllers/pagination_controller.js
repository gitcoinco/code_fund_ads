import ApplicationController from './application_controller'

export default class extends ApplicationController {
  beforeReflex () {
    window.scrollTo(0, 0)
  }
}
