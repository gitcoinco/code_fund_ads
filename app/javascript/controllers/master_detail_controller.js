import { Controller } from 'stimulus'

export default class extends Controller {
  select () {
    // TODO: find a better way
    CodeFundTheme.toggleSidebar()
  }
}
