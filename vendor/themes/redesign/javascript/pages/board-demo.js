"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Kanban Board Demo
// =============================================================
var BoardDemo =
/*#__PURE__*/
function () {
  function BoardDemo() {
    _classCallCheck(this, BoardDemo);

    this.ntTodos = [{
      id: 0,
      desc: 'Eat corn on the cob',
      checked: false
    }];
    this.init();
  }

  _createClass(BoardDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.handleModalLayerContent();
      /**
       * handle new task form components
       * nt => new task
       * dnt => dropdown new task
       */

      this.handleDntAssignees();
      this.handleDntLabels();
      this.handleNtTodos();
      this.handleNewTaskForm();
    }
  }, {
    key: "handleModalLayerContent",
    value: function handleModalLayerContent() {
      $('#modalLayer2').on('show.bs.modal', function (e) {
        var button = $(e.relatedTarget); // Button that triggered the modal

        var title = button.text(); // Get button text to display as modal title

        var recipient = button.data('content-layer'); // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.

        var modal = $(this);
        modal.find('#layer-title').text(title);
        modal.find('.modal-body').html("\n        <p>If necessary, you could initiate an AJAX request here (and then do the updating in a callback).</p>\n        <p>e.g. load <strong>".concat(recipient, "</strong> file then update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.</p>"));
      });
    }
  }, {
    key: "handleDntAssignees",
    value: function handleDntAssignees() {
      var self = this;
      $(document).on('change', '[name="taskAssignees[]"]', function () {
        // uncheck all if unassigned is checked
        if ($(this).hasClass('task-unassignees') && $('#dntmAssignees .task-unassignees').is(':checked')) {
          $('#dntmAssignees .task-assignees:checked').prop('checked', false);
        } else {
          $('#dntmAssignees .task-unassignees').prop('checked', false);
        } // get the assignees:checked then save to array


        var assignees = $('#dntmAssignees .task-assignees:checked');
        var button = $('#dntAssignees > span:first-child');
        var btnText = 'Unassigned';
        var values = [];
        assignees.each(function () {
          // push to values
          values.push($(this).data('label'));
        });
        var valuesLength = values.length;

        if (valuesLength) {
          values.sort();
          btnText = valuesLength === 1 ? values[0] : "".concat(values[0], " + ").concat(valuesLength - 1, " more");
          button.text(btnText); // show divider

          $('#dntDivider').removeClass('d-none');
        } else {
          button.text(btnText);
          $('#dntmAssignees .task-unassignees').prop('checked', true); // hide divider

          $('#dntDivider').addClass('d-none');
        } // sort by data-sort


        var listAssignees = $('#dntmAssignees > [data-sort]').get();
        var listAssigneesSorted = self.sortingElems(listAssignees); // group by :checked selector

        $.each(listAssigneesSorted, function (i, elem) {
          var $checkbox = $(elem).find('[name="taskAssignees[]"]');

          if ($checkbox.is(':checked')) {
            $('#dntDivider').before(elem);
          } else {
            $('#dntmAssignees').append(elem);
          }
        });
      });
    }
  }, {
    key: "handleDntLabels",
    value: function handleDntLabels() {
      $(document).on('change', '[name="taskLabels[]"]', function () {
        // uncheck all if unassigned is checked
        if ($(this).hasClass('task-nolabel') && $('#dntLabels .task-nolabel').is(':checked')) {
          $('#dntLabels .task-label:checked').prop('checked', false);
        } else {
          $('#dntLabels .task-nolabel').prop('checked', false);
        } // get the label:checked then save to array


        var labels = $('#dntLabels .task-label:checked');
        var button = $('#bntLabels > span:first-child');
        var btnText = 'No Label';
        var values = [];
        labels.each(function () {
          // push to values
          values.push($(this).data('label'));
        });
        var valuesLength = values.length;

        if (valuesLength) {
          values.sort();
          btnText = valuesLength === 1 ? values[0] : "".concat(values[0], " + ").concat(valuesLength - 1, " more");
          button.text(btnText);
        } else {
          button.text(btnText);
          $('#dntLabels .task-nolabel').prop('checked', true);
        }
      });
    }
  }, {
    key: "handleNtTodos",
    value: function handleNtTodos() {
      var self = this;

      var clearTodoInp = function clearTodoInp() {
        var keepFocus = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : true;
        $('#ntTodosInpt').val('').focus(); // stay focus on input field

        if (!keepFocus) {
          $('#ntTodosInpt').blur().parents('.publisher').removeClass('focus');
        }
      };

      $(document).on('keydown', '#ntTodosInpt', function (e) {
        // prevent submit on enter before keyboard release
        if (e.keyCode === 13) {
          e.preventDefault();
          return false;
        }
      }).on('keyup', '#ntTodosInpt', function (e) {
        var todo = {
          id: self.ntTodos.length,
          desc: $(this).val(),
          checked: false // on enter

        };

        if (e.keyCode === 13) {
          self.addNtTodo(todo);
          clearTodoInp();
        }
      }).on('click', '#ntTodosAdd', function () {
        self.addNtTodo({
          id: self.ntTodos.length,
          desc: $('#ntTodosInpt').val(),
          checked: false
        });
        clearTodoInp();
      }).on('click', '#ntTodosClear', function () {
        clearTodoInp(false);
      });
    }
  }, {
    key: "handleNewTaskForm",
    value: function handleNewTaskForm() {
      var self = this; // init markdown editor

      this.ntMarkdown = new SimpleMDE({
        element: document.querySelector('#taskDescription'),
        spellChecker: false,
        status: false,
        toolbar: false
      });
      $('#addNewTask').on('submit', function () {
        var form = $(this);
        var data = form.serializeArray(); // Get the file input and push to data
        // I don't want to get deep in this case
        // there is many way to handle file input, like:
        //   - http://bit.ly/2PyqlUc
        //   - http://bit.ly/2NKCAwj
        // or something else. Feel free to do it in your way.

        var files = document.querySelector('[name="taskAttachment"]').files;
        data.push({
          taskAttachment: files
        }); // clear form

        form.trigger('reset');
        self.ntMarkdown.value('');
        self.resetNtTodos(); // close modal

        $('#modalNewTask').modal('hide'); // please see form data in your console

        console.log(data);
        return false;
      });
    }
  }, {
    key: "getNtTodosMeter",
    value: function getNtTodosMeter() {
      $('#ntTodosMeter').text("0/".concat(this.ntTodos.length));
    }
  }, {
    key: "addNtTodo",
    value: function addNtTodo(todo) {
      // reuired a description
      if (todo.desc === '') {
        return;
      } // add todo to todos


      this.ntTodos.push(todo); // save todos to todos input

      $('[name="ntTodos"]').val(JSON.stringify(this.ntTodos)); // update todos meter

      this.getNtTodosMeter();
      var tmpl = "<div class=\"todo\">\n      <div class=\"custom-control custom-checkbox\">\n        <input type=\"checkbox\" class=\"custom-control-input\" id=\"todo".concat(todo.id, "\" value=\"").concat(todo.id, "\">\n        <label class=\"custom-control-label\" for=\"todo").concat(todo.id, "\">").concat(todo.desc, "</label>\n      </div>\n      <div class=\"todo-actions pr-1\">\n        <button type=\"button\" class=\"btn btn-sm btn-light\" onclick=\"boardDemo.removeNtTodo(").concat(todo.id, ")\">Delete</button>\n      </div>\n    </div>");
      $('#ntTodos').append(tmpl);
    }
  }, {
    key: "removeNtTodo",
    value: function removeNtTodo(id) {
      // remove todo from todos
      this.ntTodos = this.ntTodos.filter(function (todo) {
        return todo.id !== id;
      }); // save todos to todos input

      $('[name="ntTodos"]').val(JSON.stringify(this.ntTodos)); // update todos meter

      this.getNtTodosMeter();
      $("#todo".concat(id)).parents('.todo').remove();
    }
  }, {
    key: "resetNtTodos",
    value: function resetNtTodos() {
      // reset todos
      this.ntTodos = []; // save todos

      $('[name="ntTodos"]').val(JSON.stringify(this.ntTodos)); // update todos meter

      this.getNtTodosMeter();
      $('#ntTodos').empty();
    }
  }, {
    key: "sortingElems",
    value: function sortingElems(elems) {
      return elems.sort(function (a, b) {
        return $(a).data('sort').toUpperCase().localeCompare($(b).data('sort').toUpperCase());
      });
    }
  }]);

  return BoardDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  window.boardDemo = new BoardDemo();
});