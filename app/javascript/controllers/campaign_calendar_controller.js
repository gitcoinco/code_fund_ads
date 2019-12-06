import { Controller } from 'stimulus'
import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'
import bootstrapPlugin from '@fullcalendar/bootstrap'
import '@fullcalendar/core/main.css'
import '@fullcalendar/daygrid/main.css'
import '@fullcalendar/bootstrap/main.css'

export default class extends Controller {
  connect () {
    this.handleCalendar()
  }

  handleCalendar () {
    let calendar = new Calendar(this.element, {
      plugins: [dayGridPlugin, bootstrapPlugin],
      themeSystem: 'bootstrap',
      events: JSON.parse(this.element.dataset.events)
    })
    calendar.render()
  }
}
