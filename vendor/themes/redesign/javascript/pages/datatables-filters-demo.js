// Advance DataTables Demo
// =============================================================

class AdvanceDataTablesDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.table = this.table()
    this.globalSearch()
    this.columnSearch()
    this.selecter()
    this.clearSelected()

    // filter columns
    this.addFilterRow()
    this.removeFilterRow()
    this.clearFilter()

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
        { data: { _: 'name', sort: 'name', search: 'name'}, className: 'align-middle' },
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

  globalSearch () {
    const self = this

    $('#table-search').on('keyup focus', function (e) {
      let value = $('#table-search').val()

      // clear selected rows
      if (value.length && e.type === 'keyup') {
        self.clearSelectedRows()
      }

      self.table
        .search(value)
        .draw()
    })
  }

  columnSearch () {
    const self = this

    $(document).on('keyup change', '.filter-control', function (e) {
      const filterRow = $(this).parents('.form-row')
      const column = filterRow.find('.filter-column').val()
      const value = filterRow.find('.filter-value').val()
      const operator = value === '' ? 'contain' : filterRow.find('.filter-operator').val()
      let pattern = value
      let exp = ''

      if (operator === 'notcontain') {
        pattern = '^((?!'+ value +').)*$'
      } else if (operator === 'equal') {
        pattern = '^'+ value +'$'
      } else if (operator === 'notequal') {
        pattern = '^(?!'+ value +').*$'
      } else if (operator === 'beginwith') {
        pattern = '^('+ value + '| '+ value + ').*'
      } else if (operator === 'endwith') {
        pattern = '.*' + value + '$'
      } else if (operator === 'greaterthan') {
        const arr = value.split('')

        $.each(arr, function (i, val) {
          exp += '['+ val +'-9]'
        })

        pattern = '^('+ exp +'|[0-9][0-9]{'+ arr.length +',})*$'
      } else if (operator === 'lessthan') {
        const arr = value.split('')
        const lastIndex = arr.length - 1

        for (let x = 0; x < arr.length; x++) {
          exp += x > 0 ? '|' : ''

          $.each(arr, function (i, val) {
            if (i <= x && x === lastIndex) {
              exp += '[0-'+ val +']'
            } if (i <= x && x < lastIndex) {
              exp += '[0-9]'
            }
          })
        }

        pattern = '^('+ exp +')$'
      }

      // reset search term
      if (e.type === 'change' && $(e.target).is('select')) {
        filterRow.find('.filter-value').val('').trigger('keyup')
      }

      self.table
        .column(column)
        .search(pattern, true, true)
        .draw()
    })
  }

  addFilterRow () {
    $('#add-filter-row').on('click', function () {
      // get template from #filter-columns
      let rowTmpl = $('#filter-columns')
        .children()
        .first()
        .clone()

      rowTmpl.find('select').prop('selectedIndex', 0)
      rowTmpl.find('input').val('')

      $('#filter-columns').append(rowTmpl)
    })
  }

  removeFilterRow () {
    const self = this
    $(document).on('click', '.remove-filter-row', function () {
      // get filter row
      let $row = $(this).parents('.filter-row')
      // clear search value
      $row.find('.filter-value').val('').trigger('keyup')
      // remove row
      if (self.isRemovableRow()) {
        $row.remove()
      }
    })
  }

  isRemovableRow () {
    return $('#filter-columns').children().length > 1
  }

  clearFilter () {
    const self = this

    $(document).on('click', '#clear-filter', function () {
      // hide modal
      $('#modalFilterColumns').modal('hide')

      // reset selects and input
      $('#filter-columns').find('select').prop('selectedIndex', 0)
      $('#filter-columns').find('input').val('')

      // reset search term
      self.table
        .columns()
        .search('')
        .draw()
    })
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
  new AdvanceDataTablesDemo()
})
