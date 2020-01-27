import Rails from '@rails/ujs'
import ApplicationController from './application_controller'

export default class extends ApplicationController {
  checkAll (event) {
    Rails.stopEverything(event)
    this.setAll(true)
  }

  uncheckAll (event) {
    Rails.stopEverything(event)
    this.setAll(false)
  }

  setAll (checked) {
    this.checkboxes.forEach(el => {
      el.removeAttribute('action')
      el.checked = checked
    })
    this.invokeReflex()
  }

  invokeReflex () {
    this.stimulate(this.reflexName, this.checkedValues)
  }

  get checkboxes () {
    return Array.from(this.element.querySelectorAll('input[type="checkbox"]'))
  }

  get checkedValues () {
    return this.checkboxes.reduce((memo, checkbox) => {
      if (checkbox.checked) memo.push(checkbox.value)
      return memo
    }, [])
  }

  get reflexName () {
    return this.element.dataset.reflexName
  }
}
