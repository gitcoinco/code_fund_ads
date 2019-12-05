import { Controller } from 'stimulus'
import Gantt from 'frappe-gantt'

export default class extends Controller {
  connect () {
    const tasks = JSON.parse(this.element.dataset.items)
    let gantt = new Gantt("#gantt", tasks);
  }
}