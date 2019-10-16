// DataTables Demo
// =============================================================

class InvoiceDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.saveToPDF()
  }

  saveToPDF () {

    const worker = html2pdf()
    const element = document.getElementById('invoice')
    const $element = $(element)
    const $wrapper = $element.parent()
    const filename = $element.data('id')
    const $img = $('<img />')

    worker
      .from(element)
      .toImg()
      .then(function () {
        $element.css('display', 'none')

        $img
          .prop('alt', filename)
          .prop('src', worker.prop.img.src)
          .addClass('invoice-img')
          .css('max-width', `${$element.outerWidth()}px`)

        $wrapper.append($img)
      })


    $('#download-pdf').on('click', function (e) {
      e.preventDefault()

      worker
        .from(element)
        .toPdf()
        .save(filename)
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new InvoiceDemo()
})
