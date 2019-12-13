import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'
import { setFocus } from '../src/focus'

export default class extends Controller {
  connect () {
    StimulusReflex.register(this)
  }

  beforeReflex () {
    document.getElementById('reflex-status').classList.remove('d-none')
  }

  afterReflex () {
    document.getElementById('reflex-status').classList.add('d-none')
    setFocus()
  }
}
