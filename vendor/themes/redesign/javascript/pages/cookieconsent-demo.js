"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Cookieconsent Demo
// =============================================================
var CookieconsentDemo =
/*#__PURE__*/
function () {
  function CookieconsentDemo() {
    _classCallCheck(this, CookieconsentDemo);

    this.init();
  }

  _createClass(CookieconsentDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.handleCookie();
    }
  }, {
    key: "handleCookie",
    value: function handleCookie() {
      window.cookieconsent.initialise({
        container: document.querySelector('#cookieDemo'),
        palette: {
          popup: {
            background: '#131D28'
          },
          button: {
            background: '#F7C46C'
          }
        },
        revokable: false,
        onStatusChange: function onStatusChange(status) {
          console.log(this.hasConsented() ? 'enable cookies' : 'disable cookies');
        },
        law: {
          regionalLaw: false
        },
        location: false,
        // disable automatically adapt to the user's location for demo purpose
        content: {
          'message': 'This website uses cookies to ensure you get the best experience on our website.',
          'dismiss': 'Got it'
        }
      });
    }
  }]);

  return CookieconsentDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new CookieconsentDemo();
});