"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Ace Demo
// =============================================================
var AceDemo =
/*#__PURE__*/
function () {
  function AceDemo() {
    _classCallCheck(this, AceDemo);

    this.init();
  }

  _createClass(AceDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.handleAceEditor();
    }
  }, {
    key: "handleAceEditor",
    value: function handleAceEditor() {
      var editor = ace.edit('aceEditor');

      var StatusBar = ace.require('ace/ext/statusbar').StatusBar; // create a simple selection status indicator


      var statusBar = new StatusBar(editor, $('#statusBar')[0]);
      editor.setTheme('ace/theme/chrome');
      editor.session.setMode('ace/mode/javascript');
      editor.setAutoScrollEditorIntoView(true);
      editor.setFontSize('14px');
    }
  }]);

  return AceDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new AceDemo();
});