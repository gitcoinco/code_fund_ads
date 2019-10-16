// DataTables Demo
// =============================================================

class InvoicesListDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.table = this.table()
    this.searchRecords()
    this.selecter()
    this.clearSelected()
  }

  table () {
    // register to support date sorting
    $.fn.dataTable.moment('DD/MM/YYYY')

    return $('#invoicesTable').DataTable({
      dom: `<'table-responsive'tr>
        <'mt-4'p>`,
      language: {
        paginate: {
          previous: '<i class="fa fa-lg fa-angle-left"></i>',
          next: '<i class="fa fa-lg fa-angle-right"></i>'
        }
      },
      autoWidth: false,
      ajax: 'assets/data/invoices-list.json',
      deferRender: true,
      order: [ 3, 'dec' ],
      columns: [
        { data: 'number', className: 'col-checker align-middle', orderable: false, searchable: false },
        { data: 'number', className: 'align-middle' },
        { data: 'client', className: 'align-middle' },
        { data: 'duedate', className: 'align-middle' },
        { data: 'status', className: 'align-middle' },
        { data: 'amount', className: 'align-middle' },
        { data: 'paid', className: 'align-middle' },
        { data: 'balance', className: 'align-middle' },
        { data: 'actions', className: 'align-middle text-right', orderable: false, searchable: false }
      ],
      columnDefs: [{
        targets: 0,
        render: function (data, type, row, meta) {
          return `<div class="custom-control custom-control-nolabel custom-checkbox">
            <input type="checkbox" class="custom-control-input" name="selectedRow[]" id="p${row.number}" value="${row.number}">
            <label class="custom-control-label" for="p${row.number}"></label>
          </div>`
        }
      }, {
        targets: 1,
        render: function (data, type, row, meta) {
          return `<a href="page-invoice.html">${row.number}</a>`
        }
      }, {
        targets: 4,
        render: function (data, type, row, meta) {
          return `<span class="badge badge-subtle badge-${row.context}">${row.status}</span>`
        }
      }, {
        targets: 5,
        render: function (data, type, row, meta) {
          return `<div class="text-muted">${row.amount}</div>`
        }
      }, {
        targets: 6,
        render: function (data, type, row, meta) {
          return `<div class="text-muted">${row.paid}</div>`
        }
      }, {
        targets: 8,
        render: function (data, type, row, meta) {
          return `<div class="dropdown">
            <button type="button" class="btn btn-secondary btn-icon btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <i class="fas fa-ellipsis-h"></i>
            </button>
            <div class="dropdown-menu dropdown-menu-right">
              <div class="dropdown-arrow mr-n1"></div>
              <a href="#!${row.number}" class="dropdown-item">View</a>
              <a href="#!${row.number}" class="dropdown-item">Edit</a>
              <a href="#!${row.number}" class="dropdown-item">Send reminder</a>
              <div class="dropdown-divider"></div>
              <a href="#!${row.number}" class="dropdown-item">Download pdf</a>
              <a href="#!${row.number}" class="dropdown-item">Share to...</a>
              <div class="dropdown-divider"></div>
              <a href="#!${row.number}" class="dropdown-item">Delete</a>
            </div>
          </div>`
        }
      }]
    })
  }

  searchRecords () {
    const self = this

    $('#table-search, #filterBy').on('keyup change focus', function (e) {
      let filterBy = $('#filterBy').val()
      let hasFilter = filterBy  !== ''

      // reset search term
      self.table
        .column(4)
        .search('')
        .draw()

      if (hasFilter) {
        self.table
          .column(4)
          .search(filterBy)
          .draw()
      } else {
        self.table
          .draw()
      }
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

  selecter () {
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

  clearSelected () {
    const self = this
    // clear selected rows
    $('#invoicesTable').on('page.dt', function () {
      self.clearSelectedRows()
    })
    $('#clear-search').on('click', function () {
      self.clearSelectedRows()
    })
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
  new InvoicesListDemo()
})
