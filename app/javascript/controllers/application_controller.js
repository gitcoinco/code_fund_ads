import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'
import { setFocus } from '../src/focus'

export default class extends Controller {
  connect () {
    StimulusReflex.register(this)
  }

  afterReflex () {
    setFocus()
  }
}
