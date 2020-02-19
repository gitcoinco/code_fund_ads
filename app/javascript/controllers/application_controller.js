import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

export default class extends Controller {
  connect () {
    StimulusReflex.register(this)
  }

  afterReflex (element) {
    this.focus(element)
  }

  shouldFocus (element) {
    if (document.activeElement === element) return false
    if (element.tagName === 'TEXTAREA') return true
    if (element.tagName !== 'INPUT') return false
    if (element.type === 'hidden') return false
    return true
  }

  focus (element) {
    if (!this.shouldFocus(element)) return
    const value = element.value
    element.focus()
    element.value = ''
    element.value = value
  }
}
