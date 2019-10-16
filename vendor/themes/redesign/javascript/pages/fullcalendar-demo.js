"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// FullCalendar Demo
// =============================================================
var fcTheme = FullCalendar.Theme;

var LooperCalendarTheme = function (fcTheme) {
  function LooperCalendarTheme() {
    fcTheme.apply(this, arguments);
  }

  if (fcTheme) LooperCalendarTheme.__proto__ = fcTheme;
  LooperCalendarTheme.prototype = Object.create(fcTheme && fcTheme.prototype);
  LooperCalendarTheme.prototype.constructor = LooperCalendarTheme;
  return LooperCalendarTheme;
}(fcTheme);

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
};
LooperCalendarTheme.prototype.iconClasses = {
  close: 'fa-times',
  prev: 'fa-chevron-left',
  next: 'fa-chevron-right',
  prevYear: 'fa-angle-double-left',
  nextYear: 'fa-angle-double-right'
};
LooperCalendarTheme.prototype.baseIconClass = 'fa';
LooperCalendarTheme.prototype.iconOverrideOption = 'fontAwesome';
LooperCalendarTheme.prototype.iconOverrideCustomButtonOption = 'fontAwesome';
LooperCalendarTheme.prototype.iconOverridePrefix = 'fa-';
FullCalendar.defineThemeSystem('looper', LooperCalendarTheme);

var FullcalendarDemo =
/*#__PURE__*/
function () {
  function FullcalendarDemo() {
    _classCallCheck(this, FullcalendarDemo);

    this.init();
  }

  _createClass(FullcalendarDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.handleCalendarList();
      this.handleCalendar();
    }
  }, {
    key: "handleCalendar",
    value: function handleCalendar() {
      var capitalize = function capitalize(str) {
        return str.charAt(0).toUpperCase() + str.slice(1);
      };

      $('#calendar').fullCalendar({
        themeSystem: 'looper',
        header: {
          left: 'title',
          center: '',
          right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'month',
        height: 'auto',
        navLinks: true,
        // can click day/week names to navigate views
        editable: true,
        eventLimit: true,
        // allow "more" link when too many events
        events: 'assets/data/events.json',
        viewRender: function viewRender(view, element) {
          // update today button state :disabled
          var isToday = $('#calendar').fullCalendar('getDate').format('YYYY-MM-DD') === moment().format('YYYY-MM-DD');

          if (isToday) {
            $('#calendar-today').attr('disabled', 'disabled');
          } else {
            $('#calendar-today').removeAttr('disabled');
          } // update calendar list view


          var listType = "list".concat(capitalize(view.viewSpec.durationUnit));
          var range = listType === 'listDay' ? moment(view.start._i).format('YYYY-MM-DD') : {
            start: moment(view.start._i).format('YYYY-MM-DD'),
            end: moment(view.end._i).format('YYYY-MM-DD')
          };
          $('#calendar-list').fullCalendar('changeView', listType, range);
        }
      }); // hook the event from our buttons

      $('#calendar-prev').on('click', function () {
        $('#calendar, #calendar-list').fullCalendar('prev');
      });
      $('#calendar-today').on('click', function () {
        $('#calendar, #calendar-list').fullCalendar('today');
      });
      $('#calendar-next').on('click', function () {
        $('#calendar, #calendar-list').fullCalendar('next');
      });
    }
  }, {
    key: "handleCalendarList",
    value: function handleCalendarList() {
      $('#calendar-list').fullCalendar({
        themeSystem: 'looper',
        header: false,
        defaultView: 'listMonth',
        height: 'auto',
        navLinks: false,
        // can click day/week names to navigate views
        editable: false,
        eventLimit: false,
        // allow "more" link when too many events
        events: 'assets/data/events.json',
        eventRender: function eventRender(event, element) {
          element.find('.fc-event-dot').css('background-color', event.borderColor);
        }
      });
    }
  }]);

  return FullcalendarDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new FullcalendarDemo();
});