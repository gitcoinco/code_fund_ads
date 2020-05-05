import ApplicationController from './application_controller'

export default class extends ApplicationController {
  afterReflex () {
    eval(document.getElementById('noty').innerHTML)
  }
}
