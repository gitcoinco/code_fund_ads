// Toastr Demo
// =============================================================

class ToastrDemo {

  constructor () {

    this.init()

  }

  init () {
    toastr.options.positionClass = 'toast-top-full-width'
    toastr.options.closeButton = true
    toastr.options.progressBar = true
    toastr.options.extendedTimeOut = 0 //1000
    toastr.options.timeOut = 3000
    toastr.options.fadeOut = 250
    toastr.options.fadeIn = 250

    this.i = 0

    // event handlers
    this.handleToastr()
  }

  handleToastr () {
    $('#toastr-demo').click(() => {
      $('#toastr-demo').prop('disabled', true)
      this.delayToasts()
    })
  }

  toasts () {
    const generateToast = function (type, css, msg) {
      this.type = type
      this.css = css
      this.msg = `This is positioned in the ${msg}.`
    }

    return [
      new generateToast('info', 'toast-bottom-full-width', 'bottom full width'),
      new generateToast('error', 'toast-top-full-width', 'top full width'),
      new generateToast('warning', 'toast-top-left', 'top left'),
      new generateToast('success', 'toast-top-right', 'top right'),
      new generateToast('info', 'toast-top-center', 'top center'),
      new generateToast('info', 'toast-bottom-right', 'bottom right'),
      new generateToast('info', 'toast-bottom-left', 'bottom left'),
      new generateToast('info', 'toast-bottom-center', 'bottom center'),
    ]
  }

  delayToasts () {
    const self = this
    const toasts = self.toasts()
    const i = self.i

    if (i === toasts.length) return

    const delay = i === 0 ? 0 : 4100

    setTimeout(function () {
      self.showToast()
    }, delay)

    // re-enable the button
    if (i === toasts.length - 1) {
      setTimeout(function () {
        $('#toastr-demo').prop('disabled', false)
        self.i = 0
      }, delay + 1000)
    }
  }

  showToast () {
    const t = this.toasts()[this.i]

    toastr.options.positionClass = t.css
    toastr[t.type](t.msg)

    this.i++
    this.delayToasts()
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new ToastrDemo()
})
