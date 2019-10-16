// Kanban Board Demo
// =============================================================

class BoardDemo {

  constructor () {
    this.ntTodos = [
      {
        id: 0,
        desc: 'Eat corn on the cob',
        checked: false
      }
    ]

    this.init()
  }

  init () {

    // event handlers
    this.handleModalLayerContent()
    /**
     * handle new task form components
     * nt => new task
     * dnt => dropdown new task
     */
    this.handleDntAssignees()
    this.handleDntLabels()
    this.handleNtTodos()
    this.handleNewTaskForm()
  }

  handleModalLayerContent () {
    $('#modalLayer2').on('show.bs.modal', function (e) {
      const button = $(e.relatedTarget) // Button that triggered the modal
      const title = button.text() // Get button text to display as modal title
      const recipient = button.data('content-layer') // Extract info from data-* attributes
      // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
      // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
      const modal = $(this)
      modal.find('#layer-title').text(title)
      modal.find('.modal-body').html(`
        <p>If necessary, you could initiate an AJAX request here (and then do the updating in a callback).</p>
        <p>e.g. load <strong>${recipient}</strong> file then update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.</p>`)
    })
  }

  handleDntAssignees () {
    const self = this

    $(document).on('change', '[name="taskAssignees[]"]', function () {
      // uncheck all if unassigned is checked
      if ($(this).hasClass('task-unassignees') && $('#dntmAssignees .task-unassignees').is(':checked')) {
        $('#dntmAssignees .task-assignees:checked').prop('checked', false)
      } else {
        $('#dntmAssignees .task-unassignees').prop('checked', false)
      }

      // get the assignees:checked then save to array
      const assignees = $('#dntmAssignees .task-assignees:checked')
      const button = $('#dntAssignees > span:first-child')
      let btnText = 'Unassigned'
      let values = []

      assignees.each(function () {
        // push to values
        values.push($(this).data('label'))
      })

      let valuesLength = values.length

      if (valuesLength) {
        values.sort()
        btnText = valuesLength === 1 ? values[0] : `${values[0]} + ${valuesLength - 1} more`
        button.text(btnText)
        // show divider
        $('#dntDivider').removeClass('d-none')
      } else {
        button.text(btnText)
        $('#dntmAssignees .task-unassignees').prop('checked', true)
        // hide divider
        $('#dntDivider').addClass('d-none')
      }

      // sort by data-sort
      let listAssignees = $('#dntmAssignees > [data-sort]').get()
      let listAssigneesSorted = self.sortingElems(listAssignees)
      // group by :checked selector
      $.each(listAssigneesSorted, function (i, elem) {
        const $checkbox = $(elem).find('[name="taskAssignees[]"]')
        if ($checkbox.is(':checked')) {
          $('#dntDivider').before(elem)
        } else {
          $('#dntmAssignees').append(elem)
        }
      })
    })
  }

  handleDntLabels () {
    $(document).on('change', '[name="taskLabels[]"]', function () {
      // uncheck all if unassigned is checked
      if ($(this).hasClass('task-nolabel') && $('#dntLabels .task-nolabel').is(':checked')) {
        $('#dntLabels .task-label:checked').prop('checked', false)
      } else {
        $('#dntLabels .task-nolabel').prop('checked', false)
      }

      // get the label:checked then save to array
      const labels = $('#dntLabels .task-label:checked')
      const button = $('#bntLabels > span:first-child')
      let btnText = 'No Label'
      let values = []

      labels.each(function () {
        // push to values
        values.push($(this).data('label'))
      })

      let valuesLength = values.length

      if (valuesLength) {
        values.sort()
        btnText = valuesLength === 1 ? values[0] : `${values[0]} + ${valuesLength - 1} more`
        button.text(btnText)
      } else {
        button.text(btnText)
        $('#dntLabels .task-nolabel').prop('checked', true)
      }
    })
  }

  handleNtTodos () {
    const self = this
    const clearTodoInp = (keepFocus = true) => {
      $('#ntTodosInpt')
        .val('')
        .focus()
      // stay focus on input field
      if (!keepFocus) {
        $('#ntTodosInpt')
          .blur()
          .parents('.publisher')
          .removeClass('focus')
      }
    }

    $(document).on('keydown', '#ntTodosInpt', function (e) {
      // prevent submit on enter before keyboard release
      if(e.keyCode === 13) {
        e.preventDefault()
        return false
      }
    })
    .on('keyup', '#ntTodosInpt', function (e) {
      const todo = {
        id: self.ntTodos.length,
        desc: $(this).val(),
        checked: false
      }
      // on enter
      if(e.keyCode === 13) {
        self.addNtTodo(todo)
        clearTodoInp()
      }
    })
    .on('click', '#ntTodosAdd', function () {
      self.addNtTodo({
        id: self.ntTodos.length,
        desc: $('#ntTodosInpt').val(),
        checked: false
      })

      clearTodoInp()
    })
    .on('click', '#ntTodosClear', function () {
      clearTodoInp(false)
    })
  }

  handleNewTaskForm () {
    const self = this

    // init markdown editor
    this.ntMarkdown = new SimpleMDE({
      element: document.querySelector('#taskDescription'),
      spellChecker: false,
      status: false,
      toolbar: false
    })

    $('#addNewTask').on('submit', function () {
      const form = $(this)
      let data = form.serializeArray()

      // Get the file input and push to data
      // I don't want to get deep in this case
      // there is many way to handle file input, like:
      //   - http://bit.ly/2PyqlUc
      //   - http://bit.ly/2NKCAwj
      // or something else. Feel free to do it in your way.
      let files = document.querySelector('[name="taskAttachment"]').files
      data.push({taskAttachment: files})

      // clear form
      form.trigger('reset')
      self.ntMarkdown.value('')
      self.resetNtTodos()

      // close modal
      $('#modalNewTask').modal('hide')

      // please see form data in your console
      console.log(data)
      return false
    })
  }

  getNtTodosMeter () {
    $('#ntTodosMeter').text(`0/${this.ntTodos.length}`)
  }

  addNtTodo (todo) {
    // reuired a description
    if (todo.desc === '') {
      return
    }
    // add todo to todos
    this.ntTodos.push(todo)
    // save todos to todos input
    $('[name="ntTodos"]').val(JSON.stringify(this.ntTodos))
    // update todos meter
    this.getNtTodosMeter()

    const tmpl = `<div class="todo">
      <div class="custom-control custom-checkbox">
        <input type="checkbox" class="custom-control-input" id="todo${todo.id}" value="${todo.id}">
        <label class="custom-control-label" for="todo${todo.id}">${todo.desc}</label>
      </div>
      <div class="todo-actions pr-1">
        <button type="button" class="btn btn-sm btn-light" onclick="boardDemo.removeNtTodo(${todo.id})">Delete</button>
      </div>
    </div>`

    $('#ntTodos').append(tmpl)
  }

  removeNtTodo (id) {
    // remove todo from todos
    this.ntTodos = this.ntTodos.filter(function (todo) {
      return todo.id !== id
    })
    // save todos to todos input
    $('[name="ntTodos"]').val(JSON.stringify(this.ntTodos))
    // update todos meter
    this.getNtTodosMeter()

    $(`#todo${id}`)
      .parents('.todo')
      .remove()
  }

  resetNtTodos () {
    // reset todos
    this.ntTodos = []
    // save todos
    $('[name="ntTodos"]').val(JSON.stringify(this.ntTodos))
    // update todos meter
    this.getNtTodosMeter()

    $('#ntTodos').empty()
  }

  sortingElems (elems) {
    return elems.sort((a, b) => {
      return $(a)
        .data('sort')
        .toUpperCase()
        .localeCompare($(b).data('sort').toUpperCase())
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  window.boardDemo = new BoardDemo()
})
