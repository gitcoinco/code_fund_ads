"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Advance DataTables Demo
// =============================================================
var AdvanceDataTablesDemo =
/*#__PURE__*/
function () {
  function AdvanceDataTablesDemo() {
    _classCallCheck(this, AdvanceDataTablesDemo);

    this.init();
  }

  _createClass(AdvanceDataTablesDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.table = this.table();
      this.globalSearch();
      this.columnSearch();
      this.selecter();
      this.clearSelected(); // filter columns

      this.addFilterRow();
      this.removeFilterRow();
      this.clearFilter(); // add buttons

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
          data: {
            _: 'name',
            sort: 'name',
            search: 'name'
          },
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
    key: "globalSearch",
    value: function globalSearch() {
      var self = this;
      $('#table-search').on('keyup focus', function (e) {
        var value = $('#table-search').val(); // clear selected rows

        if (value.length && e.type === 'keyup') {
          self.clearSelectedRows();
        }

        self.table.search(value).draw();
      });
    }
  }, {
    key: "columnSearch",
    value: function columnSearch() {
      var self = this;
      $(document).on('keyup change', '.filter-control', function (e) {
        var filterRow = $(this).parents('.form-row');
        var column = filterRow.find('.filter-column').val();
        var value = filterRow.find('.filter-value').val();
        var operator = value === '' ? 'contain' : filterRow.find('.filter-operator').val();
        var pattern = value;
        var exp = '';

        if (operator === 'notcontain') {
          pattern = '^((?!' + value + ').)*$';
        } else if (operator === 'equal') {
          pattern = '^' + value + '$';
        } else if (operator === 'notequal') {
          pattern = '^(?!' + value + ').*$';
        } else if (operator === 'beginwith') {
          pattern = '^(' + value + '| ' + value + ').*';
        } else if (operator === 'endwith') {
          pattern = '.*' + value + '$';
        } else if (operator === 'greaterthan') {
          var arr = value.split('');
          $.each(arr, function (i, val) {
            exp += '[' + val + '-9]';
          });
          pattern = '^(' + exp + '|[0-9][0-9]{' + arr.length + ',})*$';
        } else if (operator === 'lessthan') {
          (function () {
            var arr = value.split('');
            var lastIndex = arr.length - 1;

            var _loop = function _loop(x) {
              exp += x > 0 ? '|' : '';
              $.each(arr, function (i, val) {
                if (i <= x && x === lastIndex) {
                  exp += '[0-' + val + ']';
                }

                if (i <= x && x < lastIndex) {
                  exp += '[0-9]';
                }
              });
            };

            for (var x = 0; x < arr.length; x++) {
              _loop(x);
            }

            pattern = '^(' + exp + ')$';
          })();
        } // reset search term


        if (e.type === 'change' && $(e.target).is('select')) {
          filterRow.find('.filter-value').val('').trigger('keyup');
        }

        self.table.column(column).search(pattern, true, true).draw();
      });
    }
  }, {
    key: "addFilterRow",
    value: function addFilterRow() {
      $('#add-filter-row').on('click', function () {
        // get template from #filter-columns
        var rowTmpl = $('#filter-columns').children().first().clone();
        rowTmpl.find('select').prop('selectedIndex', 0);
        rowTmpl.find('input').val('');
        $('#filter-columns').append(rowTmpl);
      });
    }
  }, {
    key: "removeFilterRow",
    value: function removeFilterRow() {
      var self = this;
      $(document).on('click', '.remove-filter-row', function () {
        // get filter row
        var $row = $(this).parents('.filter-row'); // clear search value

        $row.find('.filter-value').val('').trigger('keyup'); // remove row

        if (self.isRemovableRow()) {
          $row.remove();
        }
      });
    }
  }, {
    key: "isRemovableRow",
    value: function isRemovableRow() {
      return $('#filter-columns').children().length > 1;
    }
  }, {
    key: "clearFilter",
    value: function clearFilter() {
      var self = this;
      $(document).on('click', '#clear-filter', function () {
        // hide modal
        $('#modalFilterColumns').modal('hide'); // reset selects and input

        $('#filter-columns').find('select').prop('selectedIndex', 0);
        $('#filter-columns').find('input').val(''); // reset search term

        self.table.columns().search('').draw();
      });
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
    key: "clearSelectedRows",
    value: function clearSelectedRows() {
      $('#check-handle').prop('indeterminate', false).prop('checked', false).trigger('change');
    }
  }]);

  return AdvanceDataTablesDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new AdvanceDataTablesDemo();
});