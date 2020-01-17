import ApplicationController from './application_controller'

export default class extends ApplicationController {
  afterReflex () {
    alert('Report is being generated.')
  }
}
