import 'select2'
import { Controller } from 'stimulus'
import { toArray } from '../src/utils'

export default class extends Controller {
  connect () {
    this.saveOrigParentOptionsState()

    this.changeHandler = this.selectParent.bind(this)
    this.createdHandler = this.addSelect2EventListeners.bind(this)
    this.beforeCacheHandler = (() => {
      this.restoreOrigParentOptionsState()
      jQuery(this.element).off('change.select2', this.changeHandler)
    }).bind(this)

    document.addEventListener(
      'turbolinks:before-cache',
      this.beforeCacheHandler
    )
    this.element.addEventListener('select:created', this.createdHandler)
    this.addSelect2EventListeners()
  }

  addSelect2EventListeners () {
    jQuery(this.element).on('change.select2', this.changeHandler)
  }

  selectParent (event) {
    this.parentSelectTarget.value = this.selectedOption.dataset.parentId
    this.parentSelectTarget.triggeringChildOption = this.selectedOption
    this.parentSelectTarget.dispatchEvent(new Event('change'))
    setTimeout(() => delete this.parentSelectTarget.triggeringChildOption, 100)
  }

  saveOrigParentOptionsState () {
    this.parentOptions.forEach(option => {
      option.dataset.origHidden = option.hidden
      option.dataset.origDisabled = option.disabled
      option.dataset.origSelected = option.selected
    })
  }

  restoreOrigParentOptionsState (callback) {
    this.parentOptions.forEach(option => {
      option.hidden = option.dataset.origHidden === 'true'
      option.disabled = option.dataset.origDisabled === 'true'
      option.selected = option.dataset.origSelected === 'true'
    })
  }

  get selectedOption () {
    return this.options[this.element.selectedIndex]
  }

  get options () {
    return toArray(this.element.querySelectorAll('option'))
  }

  get parentSelectTarget () {
    return document.getElementById(this.element.dataset.parent)
  }

  get parentOptions () {
    return toArray(this.parentSelectTarget.querySelectorAll('option'))
  }
}
