// DataTables Demo
// =============================================================

class DataTablesDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.table = this.table()
    this.searchRecords()
    this.selecter()
    this.clearSelected()

    this.table2()

    // add buttons
    this.table
      .buttons()
      .container()
      .appendTo('#dt-buttons')
      .unwrap()
  }

  table () {
    return $('#myTable').DataTable({
      dom: `<'text-muted'Bi>
        <'table-responsive'tr>
        <'mt-4'p>`,
      buttons: [
        'copyHtml5',
        { extend: 'print', autoPrint: false }
      ],
      language: {
        paginate: {
          previous: '<i class="fa fa-lg fa-angle-left"></i>',
          next: '<i class="fa fa-lg fa-angle-right"></i>'
        }
      },
      autoWidth: false,
      ajax: 'assets/data/products.json',
      deferRender: true,
      order: [ 1, 'asc' ],
      columns: [
        { data: 'id', className: 'col-checker align-middle', orderable: false, searchable: false },
        { data: 'name', className: 'align-middle' },
        { data: 'inventory', className: 'align-middle' },
        { data: 'variant', className: 'align-middle' },
        { data: 'prices', className: 'align-middle' },
        { data: 'sales', className: 'align-middle' },
        { data: 'id', className: 'align-middle text-right', orderable: false, searchable: false }
      ],
      columnDefs: [{
        targets: 0,
        render: function (data, type, row, meta) {
          return `<div class="custom-control custom-control-nolabel custom-checkbox">
            <input type="checkbox" class="custom-control-input" name="selectedRow[]" id="p${row.id}" value="${row.id}">
            <label class="custom-control-label" for="p${row.id}"></label>
          </div>`
        }
      }, {
        targets: 1,
        render: function (data, type, row, meta) {
          return `<a href="#${row.id}" class="tile tile-img mr-1">
            <img class="img-fluid" src="assets/images/dummy/img-${row.img}.jpg" alt="Card image cap">
          </a>
          <a href="#${row.id}">${row.name}</a>`
        }
      }, {
        targets: 6,
        render: function (data, type, row, meta) {
          return `<a class="btn btn-sm btn-icon btn-secondary" href="#${data}"><i class="fa fa-pencil-alt"></i></a>
          <a class="btn btn-sm btn-icon btn-secondary" href="#${data}"><i class="far fa-trash-alt"></i></a>`
        }
      }]
    })
  }

  searchRecords () {
    const self = this

    $('#table-search, #filterBy').on('keyup change focus', function (e) {
      let filterBy = $('#filterBy').val()
      let hasFilter = filterBy  !== ''
      let value = $('#table-search').val()

      // clear selected rows
      if (value.length && (e.type === 'keyup' || e.type === 'change' )) {
        self.clearSelectedRows()
      }

      // reset search term
      self.table
        .search('')
        .columns().search('')
        .draw()

      if (hasFilter) {
        self.table
          .columns(filterBy)
          .search(value)
          .draw()
      } else {
        self.table
          .search(value)
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
    $('#myTable').on('page.dt', function () {
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

  table2 () {
    $('#myTable2').DataTable({
      dom: `<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>
        <'table-responsive'tr>
        <'row align-items-center'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 d-flex justify-content-end'p>>`,
      language: {
        paginate: {
          previous: '<i class="fa fa-lg fa-angle-left"></i>',
          next: '<i class="fa fa-lg fa-angle-right"></i>'
        }
      },
      autoWidth: false,
      ajax: 'assets/data/products.json',
      deferRender: true,
      order: [ 1, 'asc' ],
      columns: [
        { data: 'name', className: 'align-middle' },
        { data: 'inventory', className: 'align-middle' },
        { data: 'variant', className: 'align-middle' },
        { data: 'prices', className: 'align-middle' },
        { data: 'sales', className: 'align-middle' },
        { data: 'actions', className: 'align-middle text-right', orderable: false, searchable: false }
      ],
      columnDefs: [{
        targets: 0,
        render: function (data, type, row, meta) {
          return `<a href="#${row.id}" class="tile tile-img mr-1">
            <img class="img-fluid" src="assets/images/dummy/img-${row.img}.jpg" alt="Card image cap">
          </a>
          <a href="#${row.id}">${row.name}</a>`
        }
      }, {
        targets: 5,
        render: function (data, type, row, meta) {
          return `<a class="btn btn-sm btn-icon btn-secondary" href="#${data}"><i class="fa fa-pencil-alt"></i></a>
          <a class="btn btn-sm btn-icon btn-secondary" href="#${data}"><i class="far fa-trash-alt"></i></a>`
        }
      }]
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new DataTablesDemo()
})
