import { Controller } from 'stimulus'

export default class extends Controller {
  select () {
    CodeFundTheme.toggleSidebar()
  }
}
