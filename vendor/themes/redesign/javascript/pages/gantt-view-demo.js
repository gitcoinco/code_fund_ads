// Gantt View
// =============================================================

class GanttView {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleGantt()
    this.handleGanttView()

    $('#addTask').on('click', function () {
      this.addTask()
    })
  }

  handleGantt () {
    const tasks = this.getTasks()

    this.gantt = new Gantt('#gantt-target', tasks, {
      view_mode: 'Day',
      language: 'en',
      on_click: function (task) {
        console.log(task)
      },
      on_date_change: function(task, start, end) {
        console.log(task, start, end)
      },
      on_progress_change: function(task, progress) {
        console.log(task, progress)
      },
      on_view_change: function(mode) {
        console.log(mode)
      }
    })
  }

  addTask() {
    const task = {
      start: '2018-11-01',
      end: '2018-11-08',
      name: 'New Task',
      id: 'NewTask',
      progress: 50
    }
    const tasks = this.getTasks.push(task)

    this.gantt.refresh(tasks)
  }

  handleGanttView () {
    const gantt = this.gantt
    $('input[name="ganttView"]').on('change', function () {
      const view = $(this).val()

      gantt.change_view_mode(view)
    })
  }

  getTasks () {
    return [
      {
        start: '2018-11-01',
        end: '2018-11-08',
        name: 'Redesign website',
        id: 'Task 0',
        progress: 50
      },
      {
        start: '2018-11-03',
        end: '2018-11-06',
        name: 'Write new content',
        id: 'Task 1',
        progress: 60,
        dependencies: 'Task 0'
      },
      {
        start: '2018-11-04',
        end: '2018-11-08',
        name: 'Apply new styles',
        id: 'Task 2',
        progress: 10,
        dependencies: 'Task 1'
      },
      {
        start: '2018-11-08',
        end: '2018-11-09',
        name: 'Review',
        id: 'Task 3',
        progress: 5,
        dependencies: 'Task 2'
      },
      {
        start: '2018-11-10',
        end: '2018-11-12',
        name: 'Deploy',
        id: 'Task 4',
        progress: 0
      },
      {
        start: '2018-11-13',
        end: '2018-11-13',
        name: 'Go Live!',
        id: 'Task 5',
        progress: 0,
        dependencies: 'Task 4',
        custom_class: 'bar-milestone'
      },
      {
        start: '2018-11-05',
        end: '2019-01-12',
        name: 'Long term task',
        id: 'Task 6',
        progress: 60
      }
    ]
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new GanttView()
})
