"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Gantt View
// =============================================================
var GanttView =
/*#__PURE__*/
function () {
  function GanttView() {
    _classCallCheck(this, GanttView);

    this.init();
  }

  _createClass(GanttView, [{
    key: "init",
    value: function init() {
      // event handlers
      this.handleGantt();
      this.handleGanttView();
      $('#addTask').on('click', function () {
        this.addTask();
      });
    }
  }, {
    key: "handleGantt",
    value: function handleGantt() {
      var tasks = this.getTasks();
      this.gantt = new Gantt('#gantt-target', tasks, {
        view_mode: 'Day',
        language: 'en',
        on_click: function on_click(task) {
          console.log(task);
        },
        on_date_change: function on_date_change(task, start, end) {
          console.log(task, start, end);
        },
        on_progress_change: function on_progress_change(task, progress) {
          console.log(task, progress);
        },
        on_view_change: function on_view_change(mode) {
          console.log(mode);
        }
      });
    }
  }, {
    key: "addTask",
    value: function addTask() {
      var task = {
        start: '2018-11-01',
        end: '2018-11-08',
        name: 'New Task',
        id: 'NewTask',
        progress: 50
      };
      var tasks = this.getTasks.push(task);
      this.gantt.refresh(tasks);
    }
  }, {
    key: "handleGanttView",
    value: function handleGanttView() {
      var gantt = this.gantt;
      $('input[name="ganttView"]').on('change', function () {
        var view = $(this).val();
        gantt.change_view_mode(view);
      });
    }
  }, {
    key: "getTasks",
    value: function getTasks() {
      return [{
        start: '2018-11-01',
        end: '2018-11-08',
        name: 'Redesign website',
        id: 'Task 0',
        progress: 50
      }, {
        start: '2018-11-03',
        end: '2018-11-06',
        name: 'Write new content',
        id: 'Task 1',
        progress: 60,
        dependencies: 'Task 0'
      }, {
        start: '2018-11-04',
        end: '2018-11-08',
        name: 'Apply new styles',
        id: 'Task 2',
        progress: 10,
        dependencies: 'Task 1'
      }, {
        start: '2018-11-08',
        end: '2018-11-09',
        name: 'Review',
        id: 'Task 3',
        progress: 5,
        dependencies: 'Task 2'
      }, {
        start: '2018-11-10',
        end: '2018-11-12',
        name: 'Deploy',
        id: 'Task 4',
        progress: 0
      }, {
        start: '2018-11-13',
        end: '2018-11-13',
        name: 'Go Live!',
        id: 'Task 5',
        progress: 0,
        dependencies: 'Task 4',
        custom_class: 'bar-milestone'
      }, {
        start: '2018-11-05',
        end: '2019-01-12',
        name: 'Long term task',
        id: 'Task 6',
        progress: 60
      }];
    }
  }]);

  return GanttView;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new GanttView();
});