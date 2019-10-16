// DataTables Demo
// =============================================================

class TableDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleSelecter()
  }

  handleSelecter () {
    const self = this

    $(document).on('change', '#check-handle', function () {
      const isChecked = $(this).prop('checked')
      $('input[name="selectedRow[]"]').prop('checked', isChecked)

      // get info
      self.getSelectedInfo()
    })
    .on('change', 'input[name="selectedRow[]"]', function () {
      const $selectors = $('input[name="selectedRow[]"]')
      const $selectedRow = $('input[name="selectedRow[]"]:checked').length
      const prop = $selectedRow === $selectors.length
        ? 'checked'
        : 'indeterminate'

      // reset props
      $('#check-handle')
        .prop('indeterminate', false)
        .prop('checked', false)

      if ($selectedRow) {
        $('#check-handle').prop(prop, true)
      }

      // get info
      self.getSelectedInfo()
    })
  }

  getSelectedInfo () {
    const $selectedRow = $('input[name="selectedRow[]"]:checked').length
    const $info = $('.thead-btn')
    const $badge = $('<span/>')
      .addClass('selected-row-info text-muted pl-1')
      .text(`${$selectedRow} selected`)
    // remove existing info
    $('.selected-row-info').remove()
    // add current info
    if ($selectedRow) {
      $info.prepend($badge)
    }
  }

  clearSelectedRows () {
    $('#check-handle')
      .prop('indeterminate', false)
      .prop('checked', false)
      .trigger('change')
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new TableDemo()
})
