"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// noUiSlider Demo
// =============================================================
var NouisliderDemo =
/*#__PURE__*/
function () {
  function NouisliderDemo() {
    _classCallCheck(this, NouisliderDemo);

    this.init();
  }

  _createClass(NouisliderDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.colorpickerSlider();
      this.inputElementSlider();
      this.nonLinearSlider();
      this.lockingSlider();
      this.coloredSlider();
      this.keypressSlider();
      this.skippingStepSlider();
      this.hugeNumberSlider();
      this.keyboardSlider();
      this.datesSlider();
      this.softLimitSlider();
    }
  }, {
    key: "colorpickerSlider",
    value: function colorpickerSlider() {
      var $resultElement = $('#ncp-result');
      var red = $('#red')[0];
      var green = $('#green')[0];
      var blue = $('#blue')[0]; // The setColor function

      var setColor = function setColor() {
        // Get the slider values, stick them together.
        var color = "rgb(".concat(red.noUiSlider.get(), ", ").concat(green.noUiSlider.get(), ", ").concat(blue.noUiSlider.get(), ")"); // Fill the color box.

        $resultElement.css({
          background: color,
          color: color
        });
      }; // Bind the color changing function
      // to the slide event.


      red.noUiSlider.on('slide', setColor);
      green.noUiSlider.on('slide', setColor);
      blue.noUiSlider.on('slide', setColor);
    }
  }, {
    key: "inputElementSlider",
    value: function inputElementSlider() {
      // slider selector
      var selector = $('#html5')[0]; // Appending <option> elements

      var $select = $('#input-select'); // Append the option elements

      for (var i = -20; i <= 40; i++) {
        var $option = $('<option />');
        $option.text(i);
        $option.val(i);
        $select.append($option);
      } // Linking the <select> and <input>


      var $inputNumber = $('#input-number');
      selector.noUiSlider.on('update', function (values, handle) {
        var value = values[handle];

        if (handle) {
          $inputNumber.val(value);
        } else {
          $select.val(Math.round(value));
        }
      });
      $select.on('change', function () {
        selector.noUiSlider.set([this.value, null]);
      });
      $inputNumber.on('change', function () {
        selector.noUiSlider.set([null, this.value]);
      });
    }
  }, {
    key: "nonLinearSlider",
    value: function nonLinearSlider() {
      var selector = $('#nonlinear')[0]; // Read the slider value and the left offset

      var nodes = [$('#lower-value')[0], // 0
      $('#upper-value')[0] // 1
      ]; // Display the slider value and how far the handle moved
      // from the left edge of the slider.

      selector.noUiSlider.on('update', function (values, handle, unencoded, isTap, positions) {
        nodes[handle].innerHTML = values[handle] + ', ' + positions[handle].toFixed(2) + '%';
      });
    }
  }, {
    key: "lockingSlider",
    value: function lockingSlider() {
      var selector1 = $('#slider1')[0];
      var selector2 = $('#slider2')[0];
      var $lockButton = $('#lockbutton');
      var $slider1Value = $('#slider1-span');
      var $slider2Value = $('#slider2-span');
      var lockedState = false;
      var lockedValues = [60, 80]; // When the button is clicked, the locked
      // state is inverted.

      $lockButton.on('click', function () {
        lockedState = !lockedState;
        this.textContent = lockedState ? 'Unlock' : 'Lock';
      }); // The Crossupdate function

      var crossUpdate = function crossUpdate(value, slider) {
        // If the sliders aren't interlocked, don't
        // cross-update.
        if (!lockedState) return; // Select whether to increase or decrease
        // the other slider value.

        var a = selector1 === slider ? 0 : 1;
        var b = a ? 0 : 1; // Offset the slider value.

        value -= lockedValues[b] - lockedValues[a]; // Set the value

        slider.noUiSlider.set(value);
      };

      selector1.noUiSlider.on('update', function (values, handle) {
        $slider1Value.html(values[handle]);
      });
      selector2.noUiSlider.on('update', function (values, handle) {
        $slider2Value.html(values[handle]);
      }); // Linking the sliders together

      var setLockedValues = function setLockedValues() {
        lockedValues = [Number(selector1.noUiSlider.get()), Number(selector2.noUiSlider.get())];
      };

      selector1.noUiSlider.on('change', setLockedValues);
      selector2.noUiSlider.on('change', setLockedValues); // The value will be send to the other slider,
      // using a custom function as the serialization
      // method. The function uses the global 'lockedState'
      // variable to decide whether the other slider is updated.

      selector1.noUiSlider.on('slide', function (values, handle) {
        crossUpdate(values[handle], selector2);
      });
      selector2.noUiSlider.on('slide', function (values, handle) {
        crossUpdate(values[handle], selector1);
      });
    }
  }, {
    key: "coloredSlider",
    value: function coloredSlider() {
      var $connects = $('#slider-color .noUi-connect');
      var classes = ['bg-primary', 'bg-danger', 'bg-success', 'bg-warning'];
      $connects.each(function (i) {
        $(this).addClass(classes[i]);
      });
    }
  }, {
    key: "keypressSlider",
    value: function keypressSlider() {
      var selector = $('#keypress')[0];
      var input0 = $('#input-with-keypress-0');
      var input1 = $('#input-with-keypress-1');
      var inputs = [input0, input1];
      selector.noUiSlider.on('update', function (values, handle) {
        inputs[handle].val(values[handle]);
      }); // Listen to keypress on the input

      var setSliderHandle = function setSliderHandle(i, value) {
        var r = [null, null];
        r[i] = value;
        selector.noUiSlider.set(r);
      }; // Listen to keydown events on the input field.


      inputs.forEach(function (input, handle) {
        input.on('change', function () {
          setSliderHandle(handle, this.value);
        });
        input.on('keydown', function (e) {
          var values = selector.noUiSlider.get();
          var value = Number(values[handle]); // [[handle0_down, handle0_up], [handle1_down, handle1_up]]

          var steps = selector.noUiSlider.steps(); // [down, up]

          var step = steps[handle];
          var position; // 13 is enter,
          // 38 is key up,
          // 40 is key down.

          switch (e.which) {
            case 13:
              setSliderHandle(handle, this.value);
              break;

            case 38:
              // Get step to go increase slider value (up)
              position = step[1]; // false = no step is set

              if (position === false) {
                position = 1;
              } // null = edge of slider


              if (position !== null) {
                setSliderHandle(handle, value + position);
              }

              break;

            case 40:
              position = step[0];

              if (position === false) {
                position = 1;
              }

              if (position !== null) {
                setSliderHandle(handle, value - position);
              }

              break;
          }
        });
      });
    }
  }, {
    key: "skippingStepSlider",
    value: function skippingStepSlider() {
      var selector = $('#skipstep')[0]; // Read the slider values

      var skipValues = [$('#skip-value-lower'), $('#skip-value-upper')];
      selector.noUiSlider.on('update', function (values, handle) {
        skipValues[handle].html(values[handle]);
      });
    }
  }, {
    key: "hugeNumberSlider",
    value: function hugeNumberSlider() {
      var selector = $('#slider-huge')[0];
      var $bigValueSpan = $('#huge-value'); // numbers.

      var range = [0, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 134217728, 268435456, 536870912, 1073741824, 2147483648, 4294967296, 8589934592];
      var formater = wNumb({
        mark: '.',
        thousand: ',',
        prefix: '$ '
      });
      selector.noUiSlider.on('update', function (values, handle) {
        $bigValueSpan.html(formater.to(range[values[handle]]));
      });
    }
  }, {
    key: "keyboardSlider",
    value: function keyboardSlider() {
      var selector = $('#keyboard')[0]; // Listen to keypress on the handle

      var $handle = $('#keyboard .noUi-handle');
      $handle.attr('tabindex', 0);
      $handle.on('click', function () {
        this.focus();
      }).on('keydown', function (e) {
        var value = Number(selector.noUiSlider.get());

        switch (e.which) {
          case 37:
            selector.noUiSlider.set(value - 10);
            break;

          case 39:
            selector.noUiSlider.set(value + 10);
            break;
        }
      });
    }
  }, {
    key: "datesSlider",
    value: function datesSlider() {
      // Setup
      var selector = $('#slider-date')[0]; // Helper functions and formatting
      // Create a list of day and monthnames.

      var weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
      var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']; // Append a suffix to dates.
      // Example: 23 => 23rd, 1 => 1st.

      var nth = function nth(d) {
        if (d > 3 && d < 21) return 'th';

        switch (d % 10) {
          case 1:
            return 'st';

          case 2:
            return 'nd';

          case 3:
            return 'rd';

          default:
            return 'th';
        }
      }; // Create a string representation of the date.


      var formatDate = function formatDate(date) {
        return weekdays[date.getDay()] + ', ' + date.getDate() + nth(date.getDate()) + ' ' + months[date.getMonth()] + ' ' + date.getFullYear();
      }; // Slider control


      var dateValues = [$('#event-start'), $('#event-end')];
      selector.noUiSlider.on('update', function (values, handle) {
        dateValues[handle].html(formatDate(new Date(+values[handle])));
      });
    }
  }, {
    key: "softLimitSlider",
    value: function softLimitSlider() {
      var selector = $('#slider-soft')[0]; // Resetting using the change event

      selector.noUiSlider.on('change', function (values, handle) {
        if (values[handle] < 20) {
          selector.noUiSlider.set(20);
        } else if (values[handle] > 80) {
          selector.noUiSlider.set(80);
        }
      });
    }
  }]);

  return NouisliderDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new NouisliderDemo();
});