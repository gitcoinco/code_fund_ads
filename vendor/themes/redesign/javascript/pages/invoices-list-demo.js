"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// DataTables Demo
// =============================================================
var InvoicesListDemo =
/*#__PURE__*/
function () {
  function InvoicesListDemo() {
    _classCallCheck(this, InvoicesListDemo);

    this.init();
  }

  _createClass(InvoicesListDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.table = this.table();
      this.searchRecords();
      this.selecter();
      this.clearSelected();
    }
  }, {
    key: "table",
    value: function table() {
      // register to support date sorting
      $.fn.dataTable.moment('DD/MM/YYYY');
      return $('#invoicesTable').DataTable({
        dom: "<'table-responsive'tr>\n        <'mt-4'p>",
        language: {
          paginate: {
            previous: '<i class="fa fa-lg fa-angle-left"></i>',
            next: '<i class="fa fa-lg fa-angle-right"></i>'
          }
        },
        autoWidth: false,
        ajax: 'assets/data/invoices-list.json',
        deferRender: true,
        order: [3, 'dec'],
        columns: [{
          data: 'number',
          className: 'col-checker align-middle',
          orderable: false,
          searchable: false
        }, {
          data: 'number',
          className: 'align-middle'
        }, {
          data: 'client',
          className: 'align-middle'
        }, {
          data: 'duedate',
          className: 'align-middle'
        }, {
          data: 'status',
          className: 'align-middle'
        }, {
          data: 'amount',
          className: 'align-middle'
        }, {
          data: 'paid',
          className: 'align-middle'
        }, {
          data: 'balance',
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
            return "<div class=\"custom-control custom-control-nolabel custom-checkbox\">\n            <input type=\"checkbox\" class=\"custom-control-input\" name=\"selectedRow[]\" id=\"p".concat(row.number, "\" value=\"").concat(row.number, "\">\n            <label class=\"custom-control-label\" for=\"p").concat(row.number, "\"></label>\n          </div>");
          }
        }, {
          targets: 1,
          render: function render(data, type, row, meta) {
            return "<a href=\"page-invoice.html\">".concat(row.number, "</a>");
          }
        }, {
          targets: 4,
          render: function render(data, type, row, meta) {
            return "<span class=\"badge badge-subtle badge-".concat(row.context, "\">").concat(row.status, "</span>");
          }
        }, {
          targets: 5,
          render: function render(data, type, row, meta) {
            return "<div class=\"text-muted\">".concat(row.amount, "</div>");
          }
        }, {
          targets: 6,
          render: function render(data, type, row, meta) {
            return "<div class=\"text-muted\">".concat(row.paid, "</div>");
          }
        }, {
          targets: 8,
          render: function render(data, type, row, meta) {
            return "<div class=\"dropdown\">\n            <button type=\"button\" class=\"btn btn-secondary btn-icon btn-sm\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n              <i class=\"fas fa-ellipsis-h\"></i>\n            </button>\n            <div class=\"dropdown-menu dropdown-menu-right\">\n              <div class=\"dropdown-arrow mr-n1\"></div>\n              <a href=\"#!".concat(row.number, "\" class=\"dropdown-item\">View</a>\n              <a href=\"#!").concat(row.number, "\" class=\"dropdown-item\">Edit</a>\n              <a href=\"#!").concat(row.number, "\" class=\"dropdown-item\">Send reminder</a>\n              <div class=\"dropdown-divider\"></div>\n              <a href=\"#!").concat(row.number, "\" class=\"dropdown-item\">Download pdf</a>\n              <a href=\"#!").concat(row.number, "\" class=\"dropdown-item\">Share to...</a>\n              <div class=\"dropdown-divider\"></div>\n              <a href=\"#!").concat(row.number, "\" class=\"dropdown-item\">Delete</a>\n            </div>\n          </div>");
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
        var hasFilter = filterBy !== ''; // reset search term

        self.table.column(4).search('').draw();

        if (hasFilter) {
          self.table.column(4).search(filterBy).draw();
        } else {
          self.table.draw();
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

      $('#invoicesTable').on('page.dt', function () {
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
  }]);

  return InvoicesListDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new InvoicesListDemo();
});