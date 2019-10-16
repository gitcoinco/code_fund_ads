"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// DataTables Demo
// =============================================================
var DataTablesDemo =
/*#__PURE__*/
function () {
  function DataTablesDemo() {
    _classCallCheck(this, DataTablesDemo);

    this.init();
  }

  _createClass(DataTablesDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.table = this.table();
      this.searchRecords();
      this.selecter();
      this.clearSelected();
      this.table2(); // add buttons

      this.table.buttons().container().appendTo('#dt-buttons').unwrap();
    }
  }, {
    key: "table",
    value: function table() {
      return $('#myTable').DataTable({
        dom: "<'text-muted'Bi>\n        <'table-responsive'tr>\n        <'mt-4'p>",
        buttons: ['copyHtml5', {
          extend: 'print',
          autoPrint: false
        }],
        language: {
          paginate: {
            previous: '<i class="fa fa-lg fa-angle-left"></i>',
            next: '<i class="fa fa-lg fa-angle-right"></i>'
          }
        },
        autoWidth: false,
        ajax: 'assets/data/products.json',
        deferRender: true,
        order: [1, 'asc'],
        columns: [{
          data: 'id',
          className: 'col-checker align-middle',
          orderable: false,
          searchable: false
        }, {
          data: 'name',
          className: 'align-middle'
        }, {
          data: 'inventory',
          className: 'align-middle'
        }, {
          data: 'variant',
          className: 'align-middle'
        }, {
          data: 'prices',
          className: 'align-middle'
        }, {
          data: 'sales',
          className: 'align-middle'
        }, {
          data: 'id',
          className: 'align-middle text-right',
          orderable: false,
          searchable: false
        }],
        columnDefs: [{
          targets: 0,
          render: function render(data, type, row, meta) {
            return "<div class=\"custom-control custom-control-nolabel custom-checkbox\">\n            <input type=\"checkbox\" class=\"custom-control-input\" name=\"selectedRow[]\" id=\"p".concat(row.id, "\" value=\"").concat(row.id, "\">\n            <label class=\"custom-control-label\" for=\"p").concat(row.id, "\"></label>\n          </div>");
          }
        }, {
          targets: 1,
          render: function render(data, type, row, meta) {
            return "<a href=\"#".concat(row.id, "\" class=\"tile tile-img mr-1\">\n            <img class=\"img-fluid\" src=\"assets/images/dummy/img-").concat(row.img, ".jpg\" alt=\"Card image cap\">\n          </a>\n          <a href=\"#").concat(row.id, "\">").concat(row.name, "</a>");
          }
        }, {
          targets: 6,
          render: function render(data, type, row, meta) {
            return "<a class=\"btn btn-sm btn-icon btn-secondary\" href=\"#".concat(data, "\"><i class=\"fa fa-pencil-alt\"></i></a>\n          <a class=\"btn btn-sm btn-icon btn-secondary\" href=\"#").concat(data, "\"><i class=\"far fa-trash-alt\"></i></a>");
          }
        }]
      });
    }
  }, {
    key: "searchRecords",
    value: function searchRecords() {
      var self = this;
      $('#table-search, #filterBy').on('keyup change focus', function (e) {
        var filterBy = $('#filterBy').val();
        var hasFilter = filterBy !== '';
        var value = $('#table-search').val(); // clear selected rows

        if (value.length && (e.type === 'keyup' || e.type === 'change')) {
          self.clearSelectedRows();
        } // reset search term


        self.table.search('').columns().search('').draw();

        if (hasFilter) {
          self.table.columns(filterBy).search(value).draw();
        } else {
          self.table.search(value).draw();
        }
      });
    }
  }, {
    key: "getSelectedInfo",
    value: function getSelectedInfo() {
      var $selectedRow = $('input[name="selectedRow[]"]:checked').length;
      var $info = $('.thead-btn');
      var $badge = $('<span/>').addClass('selected-row-info text-muted pl-1').text("".concat($selectedRow, " selected")); // remove existing info

      $('.selected-row-info').remove(); // add current info

      if ($selectedRow) {
        $info.prepend($badge);
      }
    }
  }, {
    key: "selecter",
    value: function selecter() {
      var self = this;
      $(document).on('change', '#check-handle', function () {
        var isChecked = $(this).prop('checked');
        $('input[name="selectedRow[]"]').prop('checked', isChecked); // get info

        self.getSelectedInfo();
      }).on('change', 'input[name="selectedRow[]"]', function () {
        var $selectors = $('input[name="selectedRow[]"]');
        var $selectedRow = $('input[name="selectedRow[]"]:checked').length;
        var prop = $selectedRow === $selectors.length ? 'checked' : 'indeterminate'; // reset props

        $('#check-handle').prop('indeterminate', false).prop('checked', false);

        if ($selectedRow) {
          $('#check-handle').prop(prop, true);
        } // get info


        self.getSelectedInfo();
      });
    }
  }, {
    key: "clearSelected",
    value: function clearSelected() {
      var self = this; // clear selected rows

      $('#myTable').on('page.dt', function () {
        self.clearSelectedRows();
      });
      $('#clear-search').on('click', function () {
        self.clearSelectedRows();
      });
    }
  }, {
    key: "clearSelectedRows",
    value: function clearSelectedRows() {
      $('#check-handle').prop('indeterminate', false).prop('checked', false).trigger('change');
    }
  }, {
    key: "table2",
    value: function table2() {
      $('#myTable2').DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>\n        <'table-responsive'tr>\n        <'row align-items-center'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 d-flex justify-content-end'p>>",
        language: {
          paginate: {
            previous: '<i class="fa fa-lg fa-angle-left"></i>',
            next: '<i class="fa fa-lg fa-angle-right"></i>'
          }
        },
        autoWidth: false,
        ajax: 'assets/data/products.json',
        deferRender: true,
        order: [1, 'asc'],
        columns: [{
          data: 'name',
          className: 'align-middle'
        }, {
          data: 'inventory',
          className: 'align-middle'
        }, {
          data: 'variant',
          className: 'align-middle'
        }, {
          data: 'prices',
          className: 'align-middle'
        }, {
          data: 'sales',
          className: 'align-middle'
        }, {
          data: 'actions',
          className: 'align-middle text-right',
          orderable: false,
          searchable: false
        }],
        columnDefs: [{
          targets: 0,
          render: function render(data, type, row, meta) {
            return "<a href=\"#".concat(row.id, "\" class=\"tile tile-img mr-1\">\n            <img class=\"img-fluid\" src=\"assets/images/dummy/img-").concat(row.img, ".jpg\" alt=\"Card image cap\">\n          </a>\n          <a href=\"#").concat(row.id, "\">").concat(row.name, "</a>");
          }
        }, {
          targets: 5,
          render: function render(data, type, row, meta) {
            return "<a class=\"btn btn-sm btn-icon btn-secondary\" href=\"#".concat(data, "\"><i class=\"fa fa-pencil-alt\"></i></a>\n          <a class=\"btn btn-sm btn-icon btn-secondary\" href=\"#").concat(data, "\"><i class=\"far fa-trash-alt\"></i></a>");
          }
        }]
      });
    }
  }]);

  return DataTablesDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new DataTablesDemo();
});