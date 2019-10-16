// Summernote Demo
// =============================================================

class SummernoteDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.click2edit()
  }

  click2edit () {
    // click to edit
    const edit = function () {
      $('#summernote-click2edit').summernote({
        focus: true,
        callbacks: {
          // fix broken checkbox on link modal
          onInit: function (e) {
            const editor = $(e.editor)
            editor.find('.custom-control-description')
              .addClass('custom-control-label d-block')
              .parent()
              .removeAttr('for')
          }
        }
      })
    }

    // save after edit
    const save = function () {
      const makrup = $('#summernote-click2edit').summernote('code')
      $('#summernote-click2edit').summernote('destroy')
    }

    $('#summernote-edit').on('click', function () {
      edit()
      // toggle buttons
      $(this).addClass('d-none')
      $('#summernote-save').removeClass('d-none')
    })
    $('#summernote-save').on('click', function () {
      save()
      // toggle buttons
      $(this).addClass('d-none')
      $('#summernote-edit').removeClass('d-none')
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new SummernoteDemo()
})

