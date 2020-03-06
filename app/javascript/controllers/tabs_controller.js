import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['tab']

  initialize () {
    this.activeTabClasses = (this.data.get('activeTab') || 'active').split(' ')
    this.showTab()
  }

  change (event) {
    event.preventDefault()
    this.index = this.tabTargets.indexOf(event.currentTarget)
  }

  showTab () {
    this.tabTargets.forEach((tab, index) => {
      if (index === this.index) {
        tab.classList.add(...this.activeTabClasses)
      } else {
        tab.classList.remove(...this.activeTabClasses)
      }
    })
  }

  get index() {
    return parseInt(this.data.get('index') || 0)
  }

  set index(value) {
    this.data.set('index', value)
    this.showTab()
  }
}
