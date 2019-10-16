"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// DataTables Demo
// =============================================================
var InvoiceDemo =
/*#__PURE__*/
function () {
  function InvoiceDemo() {
    _classCallCheck(this, InvoiceDemo);

    this.init();
  }

  _createClass(InvoiceDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.saveToPDF();
    }
  }, {
    key: "saveToPDF",
    value: function saveToPDF() {
      var worker = html2pdf();
      var element = document.getElementById('invoice');
      var $element = $(element);
      var $wrapper = $element.parent();
      var filename = $element.data('id');
      var $img = $('<img />');
      worker.from(element).toImg().then(function () {
        $element.css('display', 'none');
        $img.prop('alt', filename).prop('src', worker.prop.img.src).addClass('invoice-img').css('max-width', "".concat($element.outerWidth(), "px"));
        $wrapper.append($img);
      });
      $('#download-pdf').on('click', function (e) {
        e.preventDefault();
        worker.from(element).toPdf().save(filename);
      });
    }
  }]);

  return InvoiceDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new InvoiceDemo();
});