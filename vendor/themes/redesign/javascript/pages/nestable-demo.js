"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Nestable Demo
// =============================================================
var NestableDemo =
/*#__PURE__*/
function () {
  function NestableDemo() {
    _classCallCheck(this, NestableDemo);

    this.init();
  }

  _createClass(NestableDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.handleNestable();
    }
  }, {
    key: "handleNestable",
    value: function handleNestable() {
      var _this = this;

      $('#nestable01').on('change', this.output);
      $('#nestable02').on('change', this.output); // build nestable from json data

      this.getData().done(function (data) {
        var items = '';
        $.each(data, function (index, item) {
          items += _this.buildItem(item);
        });
        $('#nestable03').children().html(items).parent().nestable().on('change', _this.output);
      });
    }
  }, {
    key: "getData",
    value: function getData() {
      return $.getJSON('assets/data/nestable.json');
    }
  }, {
    key: "buildItem",
    value: function buildItem(item) {
      var _this2 = this;

      var html = "<li class=\"dd-item\" data-id=\"".concat(item.id, "\">\n      <div class=\"dd-handle\">\n        <span class=\"drag-indicator\"></span>\n        <div>").concat(item.text, "</div>\n        <div class=\"dd-nodrag btn-group ml-auto\">\n          <button class=\"btn btn-sm btn-secondary\">Edit</button>\n          <button class=\"btn btn-sm btn-secondary\"><i class=\"far fa-trash-alt\"></i></button>\n        </div>\n      </div>");

      if (item.children) {
        html += '<ol class="dd-list">';
        $.each(item.children, function (index, sub) {
          html += _this2.buildItem(sub);
        });
        html += '</ol>';
      }

      html += '</li>';
      return html;
    }
  }, {
    key: "output",
    value: function output(e) {
      var list = e.length ? e : $(e.target);
      $('#nestableOutput').text(window.JSON.stringify(list.nestable('serialize')));
    }
  }]);

  return NestableDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new NestableDemo();
});