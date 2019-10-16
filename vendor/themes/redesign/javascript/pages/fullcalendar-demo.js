// FullCalendar Demo
// =============================================================

let fcTheme = FullCalendar.Theme

let LooperCalendarTheme = (function (fcTheme) {
  function LooperCalendarTheme () {
    fcTheme.apply(this, arguments)
  }

  if (fcTheme) LooperCalendarTheme.__proto__ = fcTheme
  LooperCalendarTheme.prototype = Object.create(fcTheme && fcTheme.prototype)
  LooperCalendarTheme.prototype.constructor = LooperCalendarTheme

  return LooperCalendarTheme
}(fcTheme))

LooperCalendarTheme.prototype.classes = {
  widget: 'fc-bootstrap4',
  tableGrid: 'table-bordered',
  tableList: 'table',
  tableListHeading: 'bg-light',
  buttonGroup: 'btn-group',
  button: 'btn btn-secondary',
  stateActive: 'active',
  stateDisabled: 'disabled',
  today: 'highlight',
  popover: 'popover',
  popoverHeader: 'popover-header',
  popoverContent: 'popover-body',
  // day grid
  // for left/right border color when border is inset from edges (all-day in agenda view)
  // avoid `table` class b/c don't want margins/padding/structure. only border color.
  headerRow: 'table-bordered',
  dayRow: 'table-bordered',
  // list view
  listView: 'card card-reflow'
}
LooperCalendarTheme.prototype.iconClasses = {
  close: 'fa-times',
  prev: 'fa-chevron-left',
  next: 'fa-chevron-right',
  prevYear: 'fa-angle-double-left',
  nextYear: 'fa-angle-double-right'
}
LooperCalendarTheme.prototype.baseIconClass = 'fa'
LooperCalendarTheme.prototype.iconOverrideOption = 'fontAwesome'
LooperCalendarTheme.prototype.iconOverrideCustomButtonOption = 'fontAwesome'
LooperCalendarTheme.prototype.iconOverridePrefix = 'fa-'

FullCalendar.defineThemeSystem('looper', LooperCalendarTheme)

class FullcalendarDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleCalendarList()
    this.handleCalendar()
  }

  handleCalendar () {
    const capitalize = function (str) {
      return str.charAt(0).toUpperCase() + str.slice(1)
    }

    $('#calendar').fullCalendar({
      themeSystem: 'looper',
      header: {
        left: 'title',
        center: '',
        right: 'month,agendaWeek,agendaDay'
      },
      defaultView: 'month',
      height: 'auto',
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      events: 'assets/data/events.json',
      viewRender: function(view, element) {
        // update today button state :disabled
        const isToday = $('#calendar').fullCalendar('getDate').format('YYYY-MM-DD') === moment().format('YYYY-MM-DD')
        if (isToday) {
          $('#calendar-today').attr('disabled', 'disabled')
        } else {
          $('#calendar-today').removeAttr('disabled')
        }

        // update calendar list view
        const listType = `list${capitalize(view.viewSpec.durationUnit)}`
        const range = listType === 'listDay'
          ? moment(view.start._i).format('YYYY-MM-DD')
          : { start: moment(view.start._i).format('YYYY-MM-DD'), end: moment(view.end._i).format('YYYY-MM-DD') }

        $('#calendar-list').fullCalendar('changeView', listType, range)
      }
    })

    // hook the event from our buttons
    $('#calendar-prev').on('click', function () {
      $('#calendar, #calendar-list').fullCalendar('prev')
    })
    $('#calendar-today').on('click', function () {
      $('#calendar, #calendar-list').fullCalendar('today')
    })
    $('#calendar-next').on('click', function () {
      $('#calendar, #calendar-list').fullCalendar('next')
    })
  }

  handleCalendarList () {
    $('#calendar-list').fullCalendar({
      themeSystem: 'looper',
      header: false,
      defaultView: 'listMonth',
      height: 'auto',
      navLinks: false, // can click day/week names to navigate views
      editable: false,
      eventLimit: false, // allow "more" link when too many events
      events: 'assets/data/events.json',
      eventRender: function(event, element) {
        element
          .find('.fc-event-dot')
          .css('background-color', event.borderColor)
      }
    })
  }
}

/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', function () {
  new FullcalendarDemo()
})

