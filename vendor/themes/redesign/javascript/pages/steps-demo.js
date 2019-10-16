// Class Template
// =============================================================

class stepsDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleValidations()
    this.handleSteps()
  }

  validateBy (trigger) {
    const $trigger = $(trigger)
    const group = $trigger.data().validate
    const groupId = $trigger.parents('.content').attr('id')
    const $groupStep = $(`[data-target="#${groupId}"]`)

    $('#stepper-form')
      .parsley()
      .on('form:validate', function (formInstance) {
        const isValid = formInstance.isValid({
          group: group
        })
        // normalize states
        $groupStep.removeClass('success error')

        // give step item a validate state
        if (isValid) {
          $groupStep.addClass('success')
          // go to next step or submit
          if ($trigger.hasClass('submit')) {
            $('#submitfeedback').toast('show')
            console.log($('#stepper-form').serializeArray())
          } else {
            stepperDemo.next()
          }
        } else {
          $groupStep.addClass('error')
        }
      })
      .validate({
        group: group
      })

    // kill listener
    $('#stepper-form')
      .parsley()
      .off('form:validate')
  }

  handleValidations () {
    const self = this
    // validate on next buttons
    $('.next').on('click', function () {
      self.validateBy(this)
    })

    // prev buttons
    $('.prev').on('click', function () {
      const $trigger = $(this)
      const groupId = $trigger.parents('.content').attr('id')
      const $groupStep = $(`[data-target="#${groupId}"]`)
      // normalize states
      $groupStep.removeClass('success error')
      $groupStep.prev().removeClass('success error')

      stepperDemo.previous()
    })

    // save creadit card
    $('#savecc').on('click', () => {
      $('#stepper-form')
        .parsley()
        .whenValidate({
          group: 'creditcard'
        })
    })

    // submit button
    $('.submit').on('click', function () {
      self.validateBy(this)

      return false
    })
  }

  handleSteps () {
    const selector = document.querySelector('#stepper')
    window.stepperDemo = new Stepper(selector, {
      linear: false
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new stepsDemo()
})
