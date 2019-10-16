// noUiSlider Demo
// =============================================================

class NouisliderDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.colorpickerSlider()
    this.inputElementSlider()
    this.nonLinearSlider()
    this.lockingSlider()
    this.coloredSlider()
    this.keypressSlider()
    this.skippingStepSlider()
    this.hugeNumberSlider()
    this.keyboardSlider()
    this.datesSlider()
    this.softLimitSlider()
  }

  colorpickerSlider () {
    const $resultElement = $('#ncp-result')
    let red = $('#red')[0]
    let green = $('#green')[0]
    let blue = $('#blue')[0]

    // The setColor function
    const setColor = () => {
      // Get the slider values, stick them together.
      const color = `rgb(${red.noUiSlider.get()}, ${green.noUiSlider.get()}, ${blue.noUiSlider.get()})`
      // Fill the color box.
      $resultElement.css({
        background: color,
        color: color
      })
    }

    // Bind the color changing function
    // to the slide event.
    red.noUiSlider.on('slide', setColor)
    green.noUiSlider.on('slide', setColor)
    blue.noUiSlider.on('slide', setColor)
  }

  inputElementSlider () {
    // slider selector
    const selector = $('#html5')[0]
    // Appending <option> elements
    const $select = $('#input-select')

    // Append the option elements
    for (let i = -20; i <= 40; i++){
      const $option = $('<option />')
      $option.text(i)
      $option.val(i)

      $select.append($option)
    }

    // Linking the <select> and <input>
    const $inputNumber = $('#input-number')
    selector.noUiSlider.on('update', (values, handle) => {
      const value = values[handle]
      if (handle) {
        $inputNumber.val(value)
      } else {
        $select.val(Math.round(value))
      }
    })

    $select.on('change', function () {
      selector.noUiSlider.set([this.value, null])
    })
    $inputNumber.on('change', function () {
      selector.noUiSlider.set([null, this.value])
    })
  }

  nonLinearSlider () {
    const selector = $('#nonlinear')[0]

    // Read the slider value and the left offset
    const nodes = [
      $('#lower-value')[0], // 0
      $('#upper-value')[0]  // 1
    ]

    // Display the slider value and how far the handle moved
    // from the left edge of the slider.
    selector.noUiSlider
      .on('update', (values, handle, unencoded, isTap, positions) => {
        nodes[handle].innerHTML = values[handle] + ', ' + positions[handle].toFixed(2) + '%'
      })
  }

  lockingSlider () {
    const selector1 = $('#slider1')[0]
    const selector2 = $('#slider2')[0]
    const $lockButton = $('#lockbutton')
    const $slider1Value = $('#slider1-span')
    const $slider2Value = $('#slider2-span')
    let lockedState = false
    let lockedValues = [60, 80]

    // When the button is clicked, the locked
    // state is inverted.
    $lockButton.on('click', function () {
      lockedState = !lockedState
      this.textContent = lockedState ? 'Unlock' : 'Lock'
    })

    // The Crossupdate function
    const crossUpdate = (value, slider) => {
      // If the sliders aren't interlocked, don't
      // cross-update.
      if (!lockedState) return
      // Select whether to increase or decrease
      // the other slider value.
      const a = selector1 === slider ? 0 : 1
      const b = a ? 0 : 1
      // Offset the slider value.
      value -= lockedValues[b] - lockedValues[a]
      // Set the value
      slider.noUiSlider.set(value)
    }

    selector1.noUiSlider.on('update', (values, handle) => {
      $slider1Value.html(values[handle])
    })
    selector2.noUiSlider.on('update', (values, handle) => {
      $slider2Value.html(values[handle])
    })

    // Linking the sliders together
    const setLockedValues = () => {
      lockedValues = [
        Number(selector1.noUiSlider.get()),
        Number(selector2.noUiSlider.get())
      ]
    }

    selector1.noUiSlider.on('change', setLockedValues)
    selector2.noUiSlider.on('change', setLockedValues)
    // The value will be send to the other slider,
    // using a custom function as the serialization
    // method. The function uses the global 'lockedState'
    // variable to decide whether the other slider is updated.
    selector1.noUiSlider.on('slide', (values, handle) => {
      crossUpdate(values[handle], selector2)
    })
    selector2.noUiSlider.on('slide', (values, handle) => {
      crossUpdate(values[handle], selector1)
    })
  }

  coloredSlider () {
    const $connects = $('#slider-color .noUi-connect')
    const classes = ['bg-primary', 'bg-danger', 'bg-success', 'bg-warning']
    $connects.each(function (i) {
      $(this).addClass(classes[i])
    })
  }

  keypressSlider () {
    const selector = $('#keypress')[0]
    const input0 = $('#input-with-keypress-0')
    const input1 = $('#input-with-keypress-1')
    const inputs = [input0, input1]

    selector.noUiSlider.on('update', (values, handle) => {
      inputs[handle].val(values[handle])
    })

    // Listen to keypress on the input
    const setSliderHandle = (i, value) => {
      const r = [null,null]
      r[i] = value
      selector.noUiSlider.set(r)
    }

    // Listen to keydown events on the input field.
    inputs.forEach(function (input, handle) {
      input.on('change', function () {
        setSliderHandle(handle, this.value)
      })

      input.on('keydown', function (e) {
        const values = selector.noUiSlider.get()
        const value = Number(values[handle])
        // [[handle0_down, handle0_up], [handle1_down, handle1_up]]
        const steps = selector.noUiSlider.steps()
        // [down, up]
        const step = steps[handle]
        let position
        // 13 is enter,
        // 38 is key up,
        // 40 is key down.
        switch ( e.which ) {
          case 13:
            setSliderHandle(handle, this.value)
            break
          case 38:
            // Get step to go increase slider value (up)
            position = step[1]
            // false = no step is set
            if ( position === false ) {
              position = 1
            }
            // null = edge of slider
            if ( position !== null ) {
              setSliderHandle(handle, value + position)
            }
            break
          case 40:
            position = step[0]
            if ( position === false ) {
              position = 1
            }
            if ( position !== null ) {
              setSliderHandle(handle, value - position)
            }
            break
        }
      })
    })
  }

  skippingStepSlider () {
    const selector = $('#skipstep')[0]
    // Read the slider values
    const skipValues = [
      $('#skip-value-lower'),
      $('#skip-value-upper')
    ]

    selector.noUiSlider.on('update', (values, handle) => {
      skipValues[handle].html(values[handle])
    })
  }

  hugeNumberSlider () {
    const selector = $('#slider-huge')[0]
    const $bigValueSpan = $('#huge-value')
    // numbers.
    const range = [0, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 134217728, 268435456, 536870912, 1073741824, 2147483648, 4294967296, 8589934592]
    const formater = wNumb({
      mark: '.',
      thousand: ',',
      prefix: '$ '
    })

    selector.noUiSlider.on('update', (values, handle) => {
      $bigValueSpan.html(formater.to(range[values[handle]]))
    })
  }

  keyboardSlider () {
    const selector = $('#keyboard')[0]
    // Listen to keypress on the handle
    const $handle = $('#keyboard .noUi-handle')

    $handle.attr('tabindex', 0)
    $handle
      .on('click', function () {
        this.focus()
      })
      .on('keydown', e => {
        const value = Number(selector.noUiSlider.get())
        switch (e.which) {
          case 37: selector.noUiSlider.set(value - 10)
            break
          case 39: selector.noUiSlider.set(value + 10)
            break
        }
      })
  }

  datesSlider () {
    // Setup
    const selector = $('#slider-date')[0]
    // Helper functions and formatting
    // Create a list of day and monthnames.
    const weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
    // Append a suffix to dates.
    // Example: 23 => 23rd, 1 => 1st.
    const nth = function (d) {
      if (d > 3 && d < 21) return 'th'
      switch (d % 10) {
        case 1:  return 'st'
        case 2:  return 'nd'
        case 3:  return 'rd'
        default: return 'th'
      }
    }
    // Create a string representation of the date.
    const formatDate = function (date) {
      return weekdays[date.getDay()] + ', ' + date.getDate() + nth(date.getDate()) + ' ' + months[date.getMonth()] + ' ' + date.getFullYear()
    }
    // Slider control
    const dateValues = [
      $('#event-start'),
      $('#event-end')
    ]

    selector.noUiSlider.on('update', (values, handle) => {
      dateValues[handle].html(formatDate(new Date(+values[handle])))
    })
  }

  softLimitSlider () {
    const selector = $('#slider-soft')[0]

    // Resetting using the change event
    selector.noUiSlider.on('change', (values, handle) => {
      if (values[handle] < 20) {
        selector.noUiSlider.set(20)
      } else if (values[handle] > 80) {
        selector.noUiSlider.set(80)
      }
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new NouisliderDemo()
})
