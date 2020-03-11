import ApplicationController from './application_controller'

export default class extends ApplicationController {
  sort (event) {
    this.stimulate('SortableReflex#sort', event.target.dataset.sortedBy)
  }

  flip () {
    this.stimulate('SortableReflex#flip')
  }
}
