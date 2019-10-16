"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Conversation Demo
// =============================================================
var ConversationDemo =
/*#__PURE__*/
function () {
  function ConversationDemo() {
    _classCallCheck(this, ConversationDemo);

    this.init();
  }

  _createClass(ConversationDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.handleScroll();
      this.handleFakeTyping();
    }
  }, {
    key: "handleScroll",
    value: function handleScroll() {
      // scroll to bottom
      var msgBody = document.querySelector('.message-body');
      msgBody.scrollTop = msgBody.scrollHeight;
    }
  }, {
    key: "handleFakeTyping",
    value: function handleFakeTyping() {
      // remove typing indicator demo after 10s
      setTimeout(function () {
        $('.conversation-list > li').last().fadeOut('slow', function () {
          $(this).remove();
        });
      }, 10000);
    }
  }]);

  return ConversationDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new ConversationDemo();
});