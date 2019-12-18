import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['invite', 'add']

  newMember (event) {
    event.preventDefault()
    event.target.dataset.value === 'add'
      ? (this.inviteTarget.checked = false)
      : (this.addTarget.checked = false)
    this.stimulate('OrganizationUsersReflex#member', event.target.dataset.value)
  }
}
