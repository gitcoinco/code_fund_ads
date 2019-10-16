"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Toastr Demo
// =============================================================
var ToastrDemo =
/*#__PURE__*/
function () {
  function ToastrDemo() {
    _classCallCheck(this, ToastrDemo);

    this.init();
  }

  _createClass(ToastrDemo, [{
    key: "init",
    value: function init() {
      toastr.options.positionClass = 'toast-top-full-width';
      toastr.options.closeButton = true;
      toastr.options.progressBar = true;
      toastr.options.extendedTimeOut = 0; //1000

      toastr.options.timeOut = 3000;
      toastr.options.fadeOut = 250;
      toastr.options.fadeIn = 250;
      this.i = 0; // event handlers

      this.handleToastr();
    }
  }, {
    key: "handleToastr",
    value: function handleToastr() {
      var _this = this;

      $('#toastr-demo').click(function () {
        $('#toastr-demo').prop('disabled', true);

        _this.delayToasts();
      });
    }
  }, {
    key: "toasts",
    value: function toasts() {
      var generateToast = function generateToast(type, css, msg) {
        this.type = type;
        this.css = css;
        this.msg = "This is positioned in the ".concat(msg, ".");
      };

      return [new generateToast('info', 'toast-bottom-full-width', 'bottom full width'), new generateToast('error', 'toast-top-full-width', 'top full width'), new generateToast('warning', 'toast-top-left', 'top left'), new generateToast('success', 'toast-top-right', 'top right'), new generateToast('info', 'toast-top-center', 'top center'), new generateToast('info', 'toast-bottom-right', 'bottom right'), new generateToast('info', 'toast-bottom-left', 'bottom left'), new generateToast('info', 'toast-bottom-center', 'bottom center')];
    }
  }, {
    key: "delayToasts",
    value: function delayToasts() {
      var self = this;
      var toasts = self.toasts();
      var i = self.i;
      if (i === toasts.length) return;
      var delay = i === 0 ? 0 : 4100;
      setTimeout(function () {
        self.showToast();
      }, delay); // re-enable the button

      if (i === toasts.length - 1) {
        setTimeout(function () {
          $('#toastr-demo').prop('disabled', false);
          self.i = 0;
        }, delay + 1000);
      }
    }
  }, {
    key: "showToast",
    value: function showToast() {
      var t = this.toasts()[this.i];
      toastr.options.positionClass = t.css;
      toastr[t.type](t.msg);
      this.i++;
      this.delayToasts();
    }
  }]);

  return ToastrDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new ToastrDemo();
});