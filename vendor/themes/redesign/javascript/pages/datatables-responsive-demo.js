// DataTables Demo
// =============================================================

class DataTablesResponsiveDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.table = this.table()
  }

  table () {
    $('#dt-responsive').DataTable({
      ajax: 'assets/data/ajax-dt.json',
      responsive: true,
      dom: `<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>
        <'table-responsive'tr>
        <'row align-items-center'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 d-flex justify-content-end'p>>`,
      language: {
        paginate: {
          previous: '<i class="fa fa-lg fa-angle-left"></i>',
          next: '<i class="fa fa-lg fa-angle-right"></i>'
        }
      },
      columns: [
        { data: 'name' },
        { data: 'position' },
        { data: 'office' },
        { data: 'start_date' },
        { data: 'extn' },
        { data: 'salary' }
      ]
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new DataTablesResponsiveDemo()
})
