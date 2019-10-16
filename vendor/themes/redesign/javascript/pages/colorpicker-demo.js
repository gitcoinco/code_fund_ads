"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Colorpicker Demo
// =============================================================
var ColorPickerDemo =
/*#__PURE__*/
function () {
  function ColorPickerDemo() {
    _classCallCheck(this, ColorPickerDemo);

    this.init();
  }

  _createClass(ColorPickerDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.customTemplateColorpicker();
    }
  }, {
    key: "customTemplateColorpicker",
    value: function customTemplateColorpicker() {
      $('#colorpicker9').colorpicker({
        inline: true,
        container: true,
        extensions: [],
        template: "<div class=\"colorpicker\">\n        <div class=\"colorpicker-saturation\"><i class=\"colorpicker-guide\"><i></i></i></div>\n        <div class=\"colorpicker-hue\"><i class=\"colorpicker-guide\"></i></div>\n        <div class=\"colorpicker-alpha\"><i class=\"colorpicker-guide\"></i></div>\n        <div class=\"colorpicker-bar hsv-output\"></div>\n      </div>"
      }).on('colorpickerChange colorpickerCreate', function (e) {
        var output = e.colorpicker.element.find('.hsv-output');
        console.log(e);
        output.html(e.color.toHslString()).css('background-color', e.color.toRgbString());

        if (e.color.isDark()) {
          output.css('color', 'white');
        } else {
          output.css('color', 'black');
        }
      });
    }
  }]);

  return ColorPickerDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new ColorPickerDemo();
});