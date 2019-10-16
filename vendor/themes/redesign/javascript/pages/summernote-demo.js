"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Summernote Demo
// =============================================================
var SummernoteDemo =
/*#__PURE__*/
function () {
  function SummernoteDemo() {
    _classCallCheck(this, SummernoteDemo);

    this.init();
  }

  _createClass(SummernoteDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.click2edit();
    }
  }, {
    key: "click2edit",
    value: function click2edit() {
      // click to edit
      var edit = function edit() {
        $('#summernote-click2edit').summernote({
          focus: true,
          callbacks: {
            // fix broken checkbox on link modal
            onInit: function onInit(e) {
              var editor = $(e.editor);
              editor.find('.custom-control-description').addClass('custom-control-label d-block').parent().removeAttr('for');
            }
          }
        });
      }; // save after edit


      var save = function save() {
        var makrup = $('#summernote-click2edit').summernote('code');
        $('#summernote-click2edit').summernote('destroy');
      };

      $('#summernote-edit').on('click', function () {
        edit(); // toggle buttons

        $(this).addClass('d-none');
        $('#summernote-save').removeClass('d-none');
      });
      $('#summernote-save').on('click', function () {
        save(); // toggle buttons

        $(this).addClass('d-none');
        $('#summernote-edit').removeClass('d-none');
      });
    }
  }]);

  return SummernoteDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new SummernoteDemo();
});