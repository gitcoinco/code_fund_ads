import Rails from '@rails/ujs'
import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['adDemoForm', 'adDemoThemeSelect', 'adDemoTemplateSelect']

  connect () {
    jQuery(this.adDemoThemeSelectTarget).on('change', this.updateAdDemo.bind(this))
    jQuery(this.adDemoTemplateSelectTarget).on('change', this.updateAdDemo.bind(this))
  }

  updateAdDemo () {
    Promise.resolve().then(() => {
      Rails.fire(this.adDemoFormTarget, 'submit')
    })
  }
}
