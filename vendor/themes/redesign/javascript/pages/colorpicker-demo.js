// Colorpicker Demo
// =============================================================

class ColorPickerDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.customTemplateColorpicker()
  }

  customTemplateColorpicker () {
    $('#colorpicker9').colorpicker({
      inline: true,
      container: true,
      extensions: [],
      template: `<div class="colorpicker">
        <div class="colorpicker-saturation"><i class="colorpicker-guide"><i></i></i></div>
        <div class="colorpicker-hue"><i class="colorpicker-guide"></i></div>
        <div class="colorpicker-alpha"><i class="colorpicker-guide"></i></div>
        <div class="colorpicker-bar hsv-output"></div>
      </div>`
    })
    .on('colorpickerChange colorpickerCreate', function (e) {
      let output = e.colorpicker.element
        .find('.hsv-output')
        console.log(e)
      output
        .html(e.color.toHslString())
        .css('background-color', e.color.toRgbString())

      if (e.color.isDark()) {
        output.css('color', 'white')
      } else {
        output.css('color', 'black')
      }
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new ColorPickerDemo()
})
